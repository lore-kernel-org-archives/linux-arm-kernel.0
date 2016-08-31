From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 31 Aug 2016 22:25:22 +0200
Subject: Changed: sunxi-ng clock code - NKMP clock implementation is wrong
In-Reply-To: <9175af7e-e1b1-df88-de2b-16f0e8d719c1@megous.com>
References: <20160715085356.GR4761@lukather>
 <085e185a-ac76-dd3f-9b0e-a7dc9c0c09f3@megous.com>
 <20160721094852.GI5993@lukather>
 <c46d1af5-9410-402a-7144-48b396ef6da7@megous.com>
 <20160726063253.GW7419@lukather>
 <e1b8127f-c422-46ab-384b-aeee85aa940b@megous.com>
 <20160728210011.GJ6682@lukather>
 <7c5f2835-f044-7c18-def9-52af5ce4afc3@megous.com>
 <20160731103114.GY6215@lukather>
 <9175af7e-e1b1-df88-de2b-16f0e8d719c1@megous.com>
Message-ID: <20160831202522.GB20462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ondrej,

Sorry for the (very) belated reply.

On Mon, Aug 01, 2016 at 12:01:39AM +0200, Ond?ej Jirman wrote:
> >>>> In the vendor code M is never anything else but 0, and P is used only
> >>>> for frequencies below 288MHz, which matches the H3 datasheet, which says:
> >>>
> >>> In the vendor code, P is never used either. All the boards we had so
> >>> far don't go that low, so we cannot make any of these assumptions,
> >>> especially since the vendor code has had the bad habit of doing
> >>> something wrong and / or useless in the past.
> >>
> >> P is used in the arisc firmware according to the spec for the lower
> >> frequencies.
> > 
> > Yes, but has anyone actually tested those frequencies? Judging from
> > the FEX files I could gather, cpufreq never actually goes lower than
> > 480 MHz.
> > 
> 
> I tested it. It works well down to 60MHz. You can even run on 24MHz if
> you run directly from 24mhz osc. It's terribly slow, but it works ok.

Ok, it's good to know (and yeah, I wouldn't expect a CPU at 24MHz to
be very fast :))

> I've rebased my working branch over the mainline kernel, which now
> contains the sunxi-ng, and tested it. Cpufreq seems to work on orange pi
> pc without any changes discussed in this thread. I didn't do any
> extensive testing though. But it doesn't hang on boot or cpufreq config
> changes.
> 
> You can see it here:
> 
> https://github.com/megous/linux/commits/orange-pi-4.8

Thanks a lot. That's good to know as well.

> >>>> "The P factor only use in the condition that PLL output less than 288
> >>>> MHz."
> >>>
> >>> And the datasheet also had some issues, either misleading or wrong
> >>> comments in the past. Don't get me wrong, I'm not saying that this is
> >>> wrong, just that we should not follow it religiously, and that we
> >>> should trust more the experiments than the datasheet.
> >>
> >> I can believe that. :) Regardless, I think the reasons given for
> >> avoiding dividers are quite reasonable. It's based on how PLL block
> >> works, not what manual says.
> > 
> > Yes, indeed.
> > 
> > Would replacing the current factors computation function by something
> > like:
> > 
> > for (m = 1; m < max_m; m++)
> >     for (p = 1; p < max_p; p++)
> >         for (n = 1; n < max_n; n++)
> > 	     for (k = 1; k < max_k; k++)
> > 	         if rate == computed rate
> > 		     break;
> > 
> > work for you?
> 
> This would be better.

Ok, I'll try to cook something up when I get the time. If you feel
like it's not done fast enough, feel free to do it.

Note that we also ended up merging for the A31 some code that reparent
CPUx temporarily while setting the PLL-CPUX rate, and it should be
somewhat generic. But of course, it's not exclusive.

Thanks again for all your tests, it's very appreciated.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160831/6fccb8c4/attachment-0001.sig>
