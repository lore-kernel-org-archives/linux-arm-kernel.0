From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 20 Sep 2016 17:27:37 +0900
Subject: [PATCH v26 6/7] arm64: kdump: update a kernel doc
In-Reply-To: <57DC18FC.9000807@arm.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <20160907042908.6232-7-takahiro.akashi@linaro.org>
 <57DC18FC.9000807@arm.com>
Message-ID: <20160920082736.GE30248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 05:08:28PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 07/09/16 05:29, AKASHI Takahiro wrote:
> > This patch adds arch specific descriptions about kdump usage on arm64
> > to kdump.txt.
> 
> > diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> 
> > @@ -249,6 +249,13 @@ Dump-capture kernel config options (Arch Dependent, arm)
> >  
> >      AUTO_ZRELADDR=y
> >  
> > +Dump-capture kernel config options (Arch Dependent, arm64)
> > +----------------------------------------------------------
> > +
> > +- Please note that kvm of the dump-capture kernel will not be enabled
> > +  on non-VHE systems even if it is configured. This is because the CPU
> > +  cannot be reset to EL2 on panic.
> 
> Nit:
> cannot be -> will not be

OK.

> We could try to do this, but its more code that could prevent us reaching the
> kdump kernel, so we choose not to.
> 
> 
> > @@ -370,6 +381,9 @@ For s390x:
> >  For arm:
> >  	"1 maxcpus=1 reset_devices"
> >  
> > +For arm64:
> > +	"1 maxcpus=1 reset_devices"
> > +
> 
> 'maxcpus=1' is a bit fragile. Since 44dbcc93ab67145 ("arm64: Fix behavior of
> maxcpus=N") udev on ubuntu vivid (running on Juno) has taken it upon itself to
> bring the secondary cores online, even when booted with 'maxcpus=1'.
> 
> Can we change the recomendation to "1 nosmp reset_devices"?

Well, I have no strong opinion here, but I'm not quite sure whether
this change does make any difference in practice.
Looking at kernel/smp.c, the only difference is setup_max_cpus. But
given that arch_disable_smp_support() is null and smp_cpus_done()
ignores "max_cpus" on arm64, I don't think that the change is very
meaningful.

I might miss something.

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James
> 
