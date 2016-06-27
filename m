From: geoff@infradead.org (Geoff Levand)
Date: Mon, 27 Jun 2016 10:00:26 -0700
Subject: [PATCH v20 04/14] arm64/kexec: Add core kexec support
In-Reply-To: <57715471.7020005@arm.com>
References: <cover.1466702804.git.geoff@infradead.org>
 <018ac873d87fbfc45185cdab91ebc8731f64f94c.1466702804.git.geoff@infradead.org>
 <57710B92.2080603@arm.com>
 <20160627143939.GC6847@e104818-lin.cambridge.arm.com>
 <57715471.7020005@arm.com>
Message-ID: <1467046826.7965.35.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2016-06-27 at 17:29 +0100, James Morse wrote:
> On 27/06/16 15:39, Catalin Marinas wrote:
> > @@ -163,7 +148,7 @@ void machine_kexec(struct kimage *kimage)
> >  > > 	> > /*
> >  > > 	> >  * New cpus may have become stuck_in_kernel after we loaded the image.
> >  > > 	> >  */
> > -> > 	> > BUG_ON(cpus_are_stuck_in_kernel() && (num_online_cpus() > 1));
> > +> > 	> > BUG_ON(cpus_are_stuck_in_kernel() || (num_online_cpus() > 1));
> >  
> >  > > 	> > reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
> >  > > 	> > reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
> > 
> 
> Yes, that's what I meant, thanks Catalin.
> 
> The 'num_online_cpus() > 1' is still needed as disable_nonboot_cpus() called via
> machine_shutdown() may have failed and this is where we check. (we can't return
> an error from either path).
> 
> Geoff, I assume you agree?

Yes, we should do a final check, and abort the reboot if if we have
more than a single cpu running.

-Geoff
