From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 30 May 2018 09:08:16 +0100
Subject: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12A672E03@dggemm507-mbx.china.huawei.com>
References: <20180529133615.26889-1-nixiaoming@huawei.com>
 <20180529154523.GK17159@arm.com>
 <E490CD805F7529488761C40FD9D26EF12A672E03@dggemm507-mbx.china.huawei.com>
Message-ID: <20180530080816.f74elebj4demiohl@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 03:31:38AM +0000, Nixiaoming wrote:
> Unable to set CONFIG_STRICT_KERNEL_RWX=n by make menuconfig ARCH=arm64

Indeed. Making this mandatory was a deliberate decision, in part because this
allows simplification of code (e.g. removal of #ifdef guards).

> When reading the code, I feel it is more appropriate to add macro control
> here.

I must disagree. I do not think it makes sense to add an #ifdef for a
configuration option that is mandatory.

There are other places in the kernel that should behave differently if
CONFIG_STRICT_KERNEL_RWX were disabled, so this wouldn't be sufficient even if
we were to make CONFIG_STRICT_KERNEL_RWX optional. i.e. the #ifdef would give
the misleading impression that STRICT_KERNEL_RWX *could* be made optional, even
though this might not function correctly.

Having an #ifdef here makes the code more complicated and confusing, for the
benefit of a case which cannot occur.

Thanks,
Mark.

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com] 
> Sent: Tuesday, May 29, 2018 11:45 PM
> To: Nixiaoming <nixiaoming@huawei.com>
> Cc: catalin.marinas at arm.com; ard.biesheuvel at linaro.org; marc.zyngier at arm.com; james.morse at arm.com; kristina.martsenko at arm.com; steve.capper at arm.com; tglx at linutronix.de; mingo at redhat.com; hpa at zytor.com; akpm at linux-foundation.org; vbabka at suse.cz; mhocko at suse.com; dave.hansen at linux.intel.com; dan.j.williams at intel.com; kirill.shutemov at linux.intel.com; zhang.jia at linux.alibaba.com; schwidefsky at de.ibm.com; heiko.carstens at de.ibm.com; gregkh at linuxfoundation.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; x86 at kernel.org; linux-s390 at vger.kernel.org
> Subject: Re: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for mark_rodata_ro
> 
> On Tue, May 29, 2018 at 09:36:15PM +0800, nixiaoming wrote:
> > mark_rodata_ro is only called by the function mark_readonly when
> > CONFIG_STRICT_KERNEL_RWX=y,
> > if CONFIG_STRICT_KERNEL_RWX is not set
> > a compile warning may be triggered: unused function
> 
> How are you achieving this configuration? In our Kconfig we select this
> unconditionally.
> 
> Will
