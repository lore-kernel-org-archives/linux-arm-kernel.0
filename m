From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Mar 2015 11:03:36 +0100
Subject: Is cpufreq-dt safe without regulator support?
In-Reply-To: <CAKohpomy6HkGYTm5KzjrWkk-RgipVkeHfoM1hLz9oAcZSWHcdg@mail.gmail.com>
References: <CAGb2v679W_NqG2d597tV9W-5ROZRTH-K542fofA_UbREDjfBhg@mail.gmail.com>
 <CAKohponnp3WgFO4nDwGwTYE9_mxzX5ttjA-Xi-9YJ7grjNcymQ@mail.gmail.com>
 <CAGb2v65z8hGdPqeW9DVa41PtMe6n8-=Gkw-YDu4mFiCbvvGT4A@mail.gmail.com>
 <CAKohpomy6HkGYTm5KzjrWkk-RgipVkeHfoM1hLz9oAcZSWHcdg@mail.gmail.com>
Message-ID: <20150318100336.GM4638@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 09:23:54AM +0530, Viresh Kumar wrote:
> >>> If the cpu is missing a regulator supply phandle, or the
> >>> kernel is built without regulators, cpufreq can increase
> >>> the clock rate without the needed voltage increase.
> >>
> >> Right.
> >>
> >>> The former issue can be resolved by providing a dummy
> >>> regulator with the default voltage, effectively disabling
> >>> cpufreq.
> >>
> >> How ? CPUFreq will try to change both volt and freq. Volt
> >> wouldn't change as its a dummy regulator, but freq would
> >> still be changed..
> >
> > I suppose this is the desired behavior. I'm fine with it then.
> >
> >>> The latter is possible. Without regulator support built-in,
> >>> even a correct, complete DTS can still fail. Should I just
> >>> remove the offending OPP? Still that does not fix the
> >>> problem when we actually do want overclocking.
> >>>
> >>> To summarize, should cpufreq-dt probe fail when regulator
> >>> support isn't available? Should we differentiate between
> >>
> >> No. We can have regulator support enabled but no regulator
> >> for a CPU. And so the current state of code looks fine.
> >>
> >>> not having a regulator phandle vs no regulator support?
> >>
> >> What I couldn't understand is, why would you miss the regulator
> >> phandle in dts? Or not compile regulator support?
> >
> > I admit it is partly bad execution on my part. I added the OPPs
> > to the .dtsi files, but only the regulators to a handful of boards
> > that I have. All the other boards do not have a regulator phandle.
> >
> >> In case you want cpufreq-dt to be disabled if regulators aren't
> >> compiled in, then what you should do is, don't create the platform
> >> device required for probing cpufreq-dt driver.
> >
> > Thanks for the suggestion. I'll add if(IS_ENABLED()) around it.
> > I can also check for the regulator phandle here.
> 
> I think the right thing to do is move the OPP bindings to the .dts
> files instead and get rid of all the hacks you are planning to add.

Another solution would be to have the safe OPPs in the DTSI, and the
one that requires some PMIC support in the board DTS.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/deb480d3/attachment.sig>
