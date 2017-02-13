From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 14 Feb 2017 07:37:19 +0800
Subject: [PATCH RFC 0/3] coresight: enable debug module
In-Reply-To: <CAJ9a7VjiEwUEQVvuecYS9aLbe+4-eN-waEWirdv_ctsHPaXxWw@mail.gmail.com>
References: <1486966298-16767-1-git-send-email-leo.yan@linaro.org>
 <CAJ9a7VjiEwUEQVvuecYS9aLbe+4-eN-waEWirdv_ctsHPaXxWw@mail.gmail.com>
Message-ID: <20170213233719.GA4711@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Mon, Feb 13, 2017 at 03:58:47PM +0000, Mike Leach wrote:
> Hi Leo,
> 
> A few comments about your driver RFC.
> 
> i) As it stands this looks like it will work for v8 cores, but would need
> refining for v7. There are subtle differences in the PC sampling between
> the two architectures.

Thanks a lot for your suggestions, I totally accept them.

For itme i) I can find detailed description in ARM-ARM 'C11.11.34
DBGPCSR, Program Counter Sampling Register', and below items I can
find corresponding description in ARMv8-ARM.

Will fix code according these comments.

Thanks,
Leo Yan

> ii) the routine that dumps the PCSR register values across all the
> available cores, appears to assume that all the cores are powered and as
> such the registers are accessible.
> I think it would be useful in the Kconfig help to point this out.
> 
> At ARM we have encountered systems that have quite aggressive power
> management policies which will disable both the core power domain and debug
> power domain for unused cores / clusters. On such a system I think that
> there would be an slave error return provided by the memory access to
> unpowered elements, resulting in undesirable behavior, or even a bus
> lockup. These are both errors we have seen using the external debug
> registers via an external debugger.
> 
> At the very least the user needs to be warned so he can adjust his system
> accordingly (e.g. when we are debugging a Juno based Linux system using the
> external debug registers / debugger. we will often disable power management
> using a script to ensure that cores stay up and debuggable.)
> 
> iii) I would recommend that you take note of the relevant bits in EDPRSR
> which may indicate that reading EDPCSR will cause an access error.
> Specifically DLK, PU would gate valid access to OSLAR -> the state of which
> you can also determine using EDPRSR.
> 
> iv) When running in higher EL levels, such as might be the case with
> trusted firmware, then PC sampling may not be permitted by the OS, when the
> EDPCSR value will return 0xFFFFFFFF. The PCSR dump message should reflect
> this.
> 
> v) EDVIDSR - which is sampled at the same time as EDPCSR_lo contains
> interesting information regarding the validity of the EDPCSR_hi registers
> and current EL and security state.
> I think it would be worth reading and interpreting this register in
> addition to the PC sample.
> 
> vi) The set of registers you are using are the "PC sample-based profiling
> extension". (ARM v8 manual section H7.) It might be more accurate to
> describe the driver as implementing support for this rather than full debug.
> 
> Best Regards
> 
> Mike Leach
> 
> 
> 
> On 13 February 2017 at 06:11, Leo Yan <leo.yan@linaro.org> wrote:
> 
> > This patch series is to enable coresight debug module. With debug
> > module we can check CPU state and PC value, etc. So this is helpful for
> > CPU lockup bugs, e.g. if one CPU has run into infinite loop with IRQ
> > disabled. The hang CPU cannot switch context and handle any interrupt,
> > so it cannot handle SMP call for stack dump, etc.
> >
> > Furthermore, now ARMv8 introduces some runtime firmwares like ARM
> > trusted firmware BL31, so sometime CPU lockup may happen in the
> > firmware and cannot return back to kernel.
> >
> > This initial patch series enable debug module and registers call back
> > notifier for PCSR register dumping when panic happens, so we can see
> > below dumping info for panic:
> >
> > [   13.751777] Coresight debug module:
> > [   13.755275] CPU[0]: PSCR=0xffff000008090cbc
> > [   13.759469] CPU[1]: PSCR=0xffff0000088bf9e4
> > [   13.763662] CPU[2]: PSCR=0xffff000008090cc0
> > [   13.767856] CPU[3]: PSCR=0xffff000008090cb8
> > [   13.772049] CPU[4]: PSCR=0xffff000008090cc0
> > [   13.776243] CPU[5]: PSCR=0xffff000008090cbc
> > [   13.780436] CPU[6]: PSCR=0xffff000008090cc0
> > [   13.784630] CPU[7]: PSCR=0xffff000008090cbc
> >
> > This patch series has been verified on 96boards Hikey.
> >
> >
> > Leo Yan (3):
> >   coresight: binding for coresight debug driver
> >   coresight: add support for debug module
> >   arm64: dts: register Hi6220's coresight debug module
> >
> >  .../devicetree/bindings/arm/coresight.txt          |   9 +-
> >  .../boot/dts/hisilicon/hikey_6220_coresight.dtsi   |  73 +++++++++
> >  drivers/hwtracing/coresight/Kconfig                |   8 +
> >  drivers/hwtracing/coresight/Makefile               |   1 +
> >  drivers/hwtracing/coresight/coresight-debug.c      | 169
> > +++++++++++++++++++++
> >  5 files changed, 258 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/hwtracing/coresight/coresight-debug.c
> >
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Blackburn Design Centre. UK
