From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Feb 2014 10:24:27 +0000
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <20140225175531.18229.77850@capellas-linux>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140222103840.GH21483@n2100.arm.linux.org.uk>
 <20140222120910.GA9012@e102568-lin.cambridge.arm.com>
 <20140223200208.12998.47604@capellas-linux>
 <20140225113251.GB6855@e102568-lin.cambridge.arm.com>
 <20140225175531.18229.77850@capellas-linux>
Message-ID: <20140226102427.GA22839@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 05:55:31PM +0000, Sebastian Capella wrote:
> Quoting Lorenzo Pieralisi (2014-02-25 03:32:51)
> > On Sun, Feb 23, 2014 at 08:02:08PM +0000, Sebastian Capella wrote:
> > > I'll go with leaving the soft_restart as is unless someone feels
> > > strongly against.
> > 
> > Leaving it as it is is fine for now, but should be commented, because that's
> > not clear why it is needed by just reading the code.
> 
> Hi Lorenzo,
> 
> How is something like this?
> 
> /*
>  * Snapshot kernel memory and reset the system.

Please add:

"swsusp_save() is executed in the suspend finisher so that the CPU context
pointer and memory are part of the saved image, which is required by the
resume kernel image to restart execution from swsusp_arch_suspend()"

>  * soft_restart is not technically needed, but is used
>  * to get success returned from cpu_suspend.
>  * After resume, the hibernation snapshot is written out.

"When soft reboot completes, the hibernation snapshot is written out."

Resume is confusing since this code is resuming twice :D on image saving
and on kernel image restoration.

Lorenzo

>  */
> static int notrace __swsusp_arch_save_image(unsigned long unused)
> {
>         int ret;
> 
>         ret = swsusp_save();
>         if (ret == 0)
>                 soft_restart(virt_to_phys(cpu_resume));
>         return ret;
> }
> 
> Thanks again for all of the feedback!
> 
> Sebastian
> 
