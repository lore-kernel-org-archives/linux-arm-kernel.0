From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 24 Jan 2017 16:52:16 +0900
Subject: [PATCH v29 4/9] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <20170123174633.GF28914@arm.com>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043605.27470-3-takahiro.akashi@linaro.org>
 <20170110113248.GC21598@arm.com>
 <20170111063626.GE20972@linaro.org>
 <20170111105405.GF12388@arm.com>
 <20170112042143.GF20972@linaro.org> <20170112120111.GE1771@arm.com>
 <20170123174633.GF28914@arm.com>
Message-ID: <20170124075214.GB23406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Mon, Jan 23, 2017 at 05:46:34PM +0000, Will Deacon wrote:
> On Thu, Jan 12, 2017 at 12:01:11PM +0000, Will Deacon wrote:
> > On Thu, Jan 12, 2017 at 01:21:44PM +0900, AKASHI Takahiro wrote:
> > > On Wed, Jan 11, 2017 at 10:54:05AM +0000, Will Deacon wrote:
> > > > On Wed, Jan 11, 2017 at 03:36:28PM +0900, AKASHI Takahiro wrote:
> > > > > On Tue, Jan 10, 2017 at 11:32:48AM +0000, Will Deacon wrote:
> > > > > > On Wed, Dec 28, 2016 at 01:36:01PM +0900, AKASHI Takahiro wrote:
> > > > > > > @@ -22,6 +25,7 @@
> > > > > > >  extern const unsigned char arm64_relocate_new_kernel[];
> > > > > > >  extern const unsigned long arm64_relocate_new_kernel_size;
> > > > > > >  
> > > > > > > +static bool in_crash_kexec;
> > > > > > 
> > > > > > Do you actually need this bool? Why not call kexec_crash_loaded() instead?
> > > > > 
> > > > > The two have different meanings:
> > > > > "in_crash_kexec" indicates that kdump is taking place, while
> > > > > kexec_crash_loaded() tells us only whether crash dump kernel has been
> > > > > loaded or not.
> > > > > 
> > > > > It is crucial to distinguish them especially for machine_kexec()
> > > > > which can be called on normal kexec even if kdump has been set up.
> > > > 
> > > > Ah, I see. So how about just doing:
> > > > 
> > > >   if (kimage == kexec_crash_image)
> > > > 
> > > > in machine_kexec?
> > > 
> > > Yeah, it should work.
> > > Do you want to merge the following hunk,
> > > or expect that I will re-send the whole patch series
> > > (with other changes if any)?
> > 
> > Thanks, I'll fold it in and shout if I run into any problems. My plan is
> > to queue this for 4.11.
> 
> Given the DT discussion with Mark, I assume you'll post a new version with
> this rolled in.

Yes, I will!

-Takahiro AKASHI

> Will
