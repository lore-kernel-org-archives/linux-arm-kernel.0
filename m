From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Jan 2017 10:54:05 +0000
Subject: [PATCH v29 4/9] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <20170111063626.GE20972@linaro.org>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043605.27470-3-takahiro.akashi@linaro.org>
 <20170110113248.GC21598@arm.com>
 <20170111063626.GE20972@linaro.org>
Message-ID: <20170111105405.GF12388@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 03:36:28PM +0900, AKASHI Takahiro wrote:
> On Tue, Jan 10, 2017 at 11:32:48AM +0000, Will Deacon wrote:
> > On Wed, Dec 28, 2016 at 01:36:01PM +0900, AKASHI Takahiro wrote:
> > > @@ -22,6 +25,7 @@
> > >  extern const unsigned char arm64_relocate_new_kernel[];
> > >  extern const unsigned long arm64_relocate_new_kernel_size;
> > >  
> > > +static bool in_crash_kexec;
> > 
> > Do you actually need this bool? Why not call kexec_crash_loaded() instead?
> 
> The two have different meanings:
> "in_crash_kexec" indicates that kdump is taking place, while
> kexec_crash_loaded() tells us only whether crash dump kernel has been
> loaded or not.
> 
> It is crucial to distinguish them especially for machine_kexec()
> which can be called on normal kexec even if kdump has been set up.

Ah, I see. So how about just doing:

  if (kimage == kexec_crash_image)

in machine_kexec?

Will
