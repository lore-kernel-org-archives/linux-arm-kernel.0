From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 31 Jul 2016 12:31:14 +0200
Subject: Changed: sunxi-ng clock code - NKMP clock implementation is wrong
In-Reply-To: <7c5f2835-f044-7c18-def9-52af5ce4afc3@megous.com>
References: <20160630204001.GC5485@lukather>
 <0b71ed7e-98c9-109e-85e6-ceb95131d88a@megous.com>
 <20160715085356.GR4761@lukather>
 <085e185a-ac76-dd3f-9b0e-a7dc9c0c09f3@megous.com>
 <20160721094852.GI5993@lukather>
 <c46d1af5-9410-402a-7144-48b396ef6da7@megous.com>
 <20160726063253.GW7419@lukather>
 <e1b8127f-c422-46ab-384b-aeee85aa940b@megous.com>
 <20160728210011.GJ6682@lukather>
 <7c5f2835-f044-7c18-def9-52af5ce4afc3@megous.com>
Message-ID: <20160731103114.GY6215@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 29, 2016 at 12:01:09AM +0200, Ond?ej Jirman wrote:
> On 28.7.2016 23:00, Maxime Ripard wrote:
> > Hi Ondrej,
> > 
> > On Thu, Jul 28, 2016 at 01:27:05PM +0200, Ond?ej Jirman wrote:
> >> Hi Maxime,
> >>
> >> I don't have your sunxi-ng clock patches in my mailbox, so I'm replying
> >> to this.
> > 
> > You can find it in the clock maintainers tree:
> > https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/log/?h=clk-sunxi-ng
> > 
> >> On 26.7.2016 08:32, Maxime Ripard wrote:
> >>> On Thu, Jul 21, 2016 at 11:52:15AM +0200, Ond?ej Jirman wrote:
> >>>>>>> If so, then yes, trying to switch to the 24MHz oscillator before
> >>>>>>> applying the factors, and then switching back when the PLL is stable
> >>>>>>> would be a nice solution.
> >>>>>>>
> >>>>>>> I just checked, and all the SoCs we've had so far have that
> >>>>>>> possibility, so if it works, for now, I'd like to stick to that.
> >>>>>>
> >>>>>> It would need to be tested. U-boot does the change only once, while the
> >>>>>> kernel would be doing it all the time and between various frequencies
> >>>>>> and PLL settings. So the issues may show up with this solution too.
> >>>>>
> >>>>> That would have the benefit of being quite easy to document, not be a
> >>>>> huge amount of code and it would work on all the CPUs PLLs we have so
> >>>>> far, so still, a pretty big win. If it doesn't, of course, we don't
> >>>>> really have the choice.
> >>>>
> >>>> It's probably more code though. It has to access different register from
> >>>> the one that is already defined in dts, which would add a lot of code
> >>>> and require dts changes. The original patch I sent is simpler than that.
> >>>
> >>> Why?
> >>>
> >>> You can use container_of to retrieve the parent structure of the clock
> >>> notifier, and then you get a ccu_common structure pointer, with the
> >>> CCU base address, the clock register, its lock, etc.
> >>>
> >>> Look at what is done in drivers/clk/meson/clk-cpu.c. It's like 20 LoC.
> >>>
> >>> I don't really get why anything should be changed in the DT, or why it
> >>> would add a lot of code. Or maybe we're not talking about the same
> >>> thing?
> >>
> >> I've looked at the new CCU code, particularly ccu_nkmp.c, and found that
> >> it very liberally uses divider parameters, even in situations that are
> >> out of spec compared to the current code in the kernel.
> >>
> >> In the current code and especially in the original vendor code, divider
> >> parameters are used as last resort only. Presumably because, of the
> >> inherent trouble in changing them, as I described to you in other email.
> >>
> >> The new ccu code uses dividers often and even at very high frequencies,
> >> which goes against the spec.
> >>
> >> In the vendor code M is never anything else but 0, and P is used only
> >> for frequencies below 288MHz, which matches the H3 datasheet, which says:
> > 
> > In the vendor code, P is never used either. All the boards we had so
> > far don't go that low, so we cannot make any of these assumptions,
> > especially since the vendor code has had the bad habit of doing
> > something wrong and / or useless in the past.
> 
> P is used in the arisc firmware according to the spec for the lower
> frequencies.

Yes, but has anyone actually tested those frequencies? Judging from
the FEX files I could gather, cpufreq never actually goes lower than
480 MHz.

> > However, this implementation is a new thing, and it was using the H3
> > precisely because of its early stage of support to use it as a testbed
> > for the more established.
> > 
> > If you feel like we should use a different formula to favour the
> > multipliers over the dividers (or want to change the class of the CPU
> > PLL to an NKM or something else, this is totally doable.
> 
> I think the original formula that's currently in the mainline kernel is
> better and avoids fiddling with dividers too much.

Yeah, but the older formula is not generic at all. The whole rework
was precisely to avoid doing the whole one driver per clock that was
just becoming a nightmare to maintain, and a pain to add support for
new SoCs. That code will be used for A10's CPU and VE PLLs too for
example. And they probably have the same constraints, but with
different variations (available values of each factors for example).

> >> "The P factor only use in the condition that PLL output less than 288
> >> MHz."
> > 
> > And the datasheet also had some issues, either misleading or wrong
> > comments in the past. Don't get me wrong, I'm not saying that this is
> > wrong, just that we should not follow it religiously, and that we
> > should trust more the experiments than the datasheet.
> 
> I can believe that. :) Regardless, I think the reasons given for
> avoiding dividers are quite reasonable. It's based on how PLL block
> works, not what manual says.

Yes, indeed.

Would replacing the current factors computation function by something
like:

for (m = 1; m < max_m; m++)
    for (p = 1; p < max_p; p++)
        for (n = 1; n < max_n; n++)
	     for (k = 1; k < max_k; k++)
	         if rate == computed rate
		     break;

work for you?

That way, we will favor the multipliers over the dividers, and we can
always "blacklist" p or m (or both) by setting their maximum to 1
(this would need an extra field in _ccu_div though).

> >> Also other datasheets of similar socs from Allwinner state that M should
> >> not be used in production code.
> > 
> > Which ones specifically?
> 
> A83T for example. You can search for "only for test" phrase.
> 
> https://github.com/allwinner-zh/documents/blob/master/A83T/A83T_User_Manual_v1.5.1_20150513.pdf
> 
> Those PLLs are a bit different though.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160731/533d46e0/attachment.sig>
