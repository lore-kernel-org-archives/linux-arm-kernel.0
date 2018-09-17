From: robert.richter@cavium.com (Robert Richter)
Date: Mon, 17 Sep 2018 19:22:07 +0200
Subject: [PATCH RESEND 3/6] arm64: add sysfs vulnerability show for
 spectre v1
In-Reply-To: <20180827143310.641-4-ykaukab@suse.de>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180827143310.641-4-ykaukab@suse.de>
Message-ID: <20180917172206.GA3795@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.08.18 16:33:07, Mian Yousaf Kaukab wrote:
> Hard-coded since patches are merged and there are no configuration
> options.

Could you add a list of upstream patches to the description that are
required to solve this? This would be a strict definition for the
mitigation being enabled and makes it easier to check if backports are
affected or not. A build-time check would be ideal (e.g. checking for
certain macros).

Looking at arm64/kpti I see the following patches:

f84a56f73ddd^..f3804203306e 669474e772b9^..91b2d3442f6a

v4.16-rc1  f84a56f73ddd Documentation: Document array_index_nospec
v4.16-rc1  f3804203306e array_index_nospec: Sanitize speculative array de-references
v4.16-rc1  669474e772b9 arm64: barrier: Add CSDB macros to control data-value prediction
v4.16-rc1  022620eed3d0 arm64: Implement array_index_mask_nospec()
v4.16-rc1  51369e398d0d arm64: Make USER_DS an inclusive limit
v4.16-rc1  4d8efc2d5ee4 arm64: Use pointer masking to limit uaccess speculation
v4.16-rc1  6314d90e6493 arm64: entry: Ensure branch through syscall table is bounded under speculation
v4.16-rc1  c2f0ad4fc089 arm64: uaccess: Prevent speculative use of the current addr_limit
v4.16-rc1  84624087dd7e arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}_user
v4.16-rc1  f71c2ffcb20d arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
v4.16-rc1  91b2d3442f6a arm64: futex: Mask __user pointers prior to dereference

-Robert

> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
>  arch/arm64/kernel/cpu_errata.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 996edb4e18ad..92616431ae4e 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -706,4 +706,10 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
>         return sprintf(buf, "Vulnerable\n");
>  }
> 
> +ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
> +               char *buf)
> +{
> +       return sprintf(buf, "Mitigation: __user pointer sanitization\n");
> +}
> +
>  #endif
> --
> 2.11.0
> 
