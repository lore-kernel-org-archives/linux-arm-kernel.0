From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Jul 2014 12:26:51 +0100
Subject: [GIT PULL 2/3] ARM: tegra: move fuse code out of arch/arm
In-Reply-To: <53CD4201.5070705@wwwdotorg.org>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
 <1403558626-13422-2-git-send-email-swarren@wwwdotorg.org>
 <20140707004417.GE8469@quad.lixom.net>
 <20140708134359.GA23218@tbergstrom-lnx.Nvidia.com>
 <CAOesGMhoqvqf-dktp-OfUNTPLahPwkyAPiTeDngr4QjH=VfOGA@mail.gmail.com>
 <53C88A4C.3070304@wwwdotorg.org>
 <CAOesGMh+zLV781wzdR5=_Bpzh+XMwJfWL-5XMDP6DwG_Hg80kw@mail.gmail.com>
 <53CD2C58.6060601@wwwdotorg.org> <20140721155451.GF32578@arm.com>
 <53CD4201.5070705@wwwdotorg.org>
Message-ID: <20140722112651.GC2219@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 05:38:25PM +0100, Stephen Warren wrote:
> On 07/21/2014 09:54 AM, Catalin Marinas wrote:
> > On arm64, I really want to get away from any SoC specific early
> > initcall. One of the main reason is for things like SCU, interconnects,
> > system cache configurations (even certain clocks) to be enabled in
> > firmware before Linux starts (it's an education process but that's a way
> > for example to prevent people sending patches to enable SoC coherency
> > because they haven't thought about it before upstreaming).
> > 
> > It would be nice to be able to initialise SoC stuff at device_initcall()
> > level (and even keep such code as modules in initramfs) but one of the
> > problems we have is dependency on clocks (and the clock model which
> > doesn't follow the device/driver model). The of_platform_populate() is
> > called at arch_initcall_sync (after arch_initcall to still allow some
> > SoC code, if needed, to run at arch_initcall).
> 
> The main thing I want to avoid is a ton of separate drivers that all
> rely on each-other getting resolved by deferred probe. While that might
> work out, it seems pointless to make the kernel try and probe a bunch of
> stuff just to have it fail and get repeated, when we know exactly which
> order everything should get initialized in.

So of_platform_populate() is called at arch_initcall_sync() level on
arm64. This allows at least two levels of probing separation before
(e.g. drivers registered as arch_initcall) and after (device_initcall).
If you register a driver earlier than arch_initcall_sync (see for
example vexpress_osc_init), it will get probed when the platform devices
are populated. Any later device_initcalls will get probed when the
corresponding drivers are registered. If you need ordering between
device_initcalls, I would recommend deferred probing.

The tricky part is if you need more drivers to be initialised at
arch_initcall_sync() in a specific order. Here it looks like the node
ordering in DT has an effect on probing. I don't say the DT should list
them in the order they should be probed but maybe we can improve the
model and do some sorting during unflattening (as I suggested in my
reply to Olof). In the meantime, for vexpress we worked around it by
explicitly checking the compatible node during a pre-arch_initcall.

> Another issue is that we have SoCs which only differ in the CPU.

Do you mean ARMv7 vs ARMv8 CPUs?

> I want
> the code to work identically on both SoCs so the CPU has limited affect
> on the low-level IO code. If we're going to enforce a "no machine
> descriptors" rule on arch/arm64, I think we should do the same thing in
> arch/arm for consistency.

We've done this with vexpress thanks to Pawel. As he said, the difficult
part was converting the existing code to the Linux device model. The
32-bit v2m_dt_init() function simply calls of_platform_populate(). If
you don't have a machine_desc at all, this would be the default (see
customize_machine()). If you use PSCI, there is no need for SoC specific
smp_ops either. So you basically get the same code base with no
additional arch/arm/mach-* machine_desc.

> > We have a similar issue with arm64 vexpress (well, just on the model)
> > where vexpress_sysreg_init() is a core_initcall (should be fine as
> > arch_initcall) as it needs to be done before of_platform_populate().
> > Pawel on cc should know more of the history here.
> > 
> > I recall there were also some discussions about a SoC driver model which
> > hangs off the top compatible string in the DT (e.g. "arm,vexpress") and
> > allow (minimal) code to be run slightly earlier, though still not
> > earlier than arch_initcall.
> 
> I guess that would work out OK; if we force the driver that binds to a
> top-level compatible value of "nvidia,tegraNNN" to probe first, and it
> then calls out to all the low-level init code in a sane order, that
> would solve the problem. I'm not sure that's any better than having a
> machine descriptor with an "init" function though; wrapping all this in
> a driver just seems like overhead, but it would work out OK.

Looking at the tegra_init_early(), I think for arm64 as
pre-arch_initcall_sync you would only need:

	tegra_init_fuse();
	tegra_powergate_init();

(I'm not sure about trusted foundations but that's a 32-bit only project
for the time being)

>From tegra_dt_init() you need clocks but isn't CLK_OF_DECLARE enough?
You also have PMC code and I'm not familiar with your implementation. A
lot of the functionality could be moved to PSCI-capable firmware.

-- 
Catalin
