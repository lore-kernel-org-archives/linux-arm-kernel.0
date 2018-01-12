From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Fri, 12 Jan 2018 09:52:03 -0800
Subject: [PATCH v3] rcutorture: Add basic ARM64 support to run scripts
In-Reply-To: <1515751892-37470-1-git-send-email-lianglihao@huawei.com>
References: <1515751892-37470-1-git-send-email-lianglihao@huawei.com>
Message-ID: <20180112175203.GX9671@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 06:11:32PM +0800, lianglihao at huawei.com wrote:
> From: Lihao Liang <lianglihao@huawei.com>
> 
> This commit adds support of the qemu command qemu-system-aarch64
> to rcutorture.
> 
> Signed-off-by: Lihao Liang <lianglihao@huawei.com>

This is to replace your previous patch, not to apply on top of it,
correct?  (Either way is fine, just please let me know.)

							Thanx, Paul

> ---
> 
> Comparing to the previous version, this patch lifts the limitation of
> maximum 8 CPUs of option "-M virt" by adding "gic-version=host" to it.
> This allows qemu to use the maximum CPU number supported by the actual
> hardware.
> 
> This commit is against RCU's git branch rcu/dev
> 
> commit 505b61b2ec1d ("EXP: rcu: Add debugging info to other assertion")
> 
> 
>  tools/testing/selftests/rcutorture/bin/functions.sh | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
> index 07a1377..65f6655 100644
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -136,6 +136,9 @@ identify_boot_image () {
>  		qemu-system-x86_64|qemu-system-i386)
>  			echo arch/x86/boot/bzImage
>  			;;
> +		qemu-system-aarch64)
> +			echo arch/arm64/boot/Image
> +			;;
>  		*)
>  			echo vmlinux
>  			;;
> @@ -158,6 +161,9 @@ identify_qemu () {
>  	elif echo $u | grep -q "Intel 80386"
>  	then
>  		echo qemu-system-i386
> +	elif echo $u | grep -q aarch64
> +	then
> +		echo qemu-system-aarch64
>  	elif uname -a | grep -q ppc64
>  	then
>  		echo qemu-system-ppc64
> @@ -176,16 +182,20 @@ identify_qemu () {
>  # Output arguments for the qemu "-append" string based on CPU type
>  # and the TORTURE_QEMU_INTERACTIVE environment variable.
>  identify_qemu_append () {
> +	local console=ttyS0
>  	case "$1" in
>  	qemu-system-x86_64|qemu-system-i386)
>  		echo noapic selinux=0 initcall_debug debug
>  		;;
> +	qemu-system-aarch64)
> +		console=ttyAMA0
> +		;;
>  	esac
>  	if test -n "$TORTURE_QEMU_INTERACTIVE"
>  	then
>  		echo root=/dev/sda
>  	else
> -		echo console=ttyS0
> +		echo console=$console
>  	fi
>  }
> 
> @@ -197,6 +207,9 @@ identify_qemu_args () {
>  	case "$1" in
>  	qemu-system-x86_64|qemu-system-i386)
>  		;;
> +	qemu-system-aarch64)
> +		echo -machine virt,gic-version=host -cpu host
> +		;;
>  	qemu-system-ppc64)
>  		echo -enable-kvm -M pseries -nodefaults
>  		echo -device spapr-vscsi
> @@ -254,7 +267,7 @@ specify_qemu_cpus () {
>  		echo $2
>  	else
>  		case "$1" in
> -		qemu-system-x86_64|qemu-system-i386)
> +		qemu-system-x86_64|qemu-system-i386|qemu-system-aarch64)
>  			echo $2 -smp $3
>  			;;
>  		qemu-system-ppc64)
> -- 
> 2.7.4
> 
