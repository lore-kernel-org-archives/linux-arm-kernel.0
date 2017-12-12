From: lianglihao@huawei.com (Lihao Liang)
Date: Tue, 12 Dec 2017 17:28:48 +0800
Subject: [PATCH] rcutorture: Add basic ARM64 support to run scripts
In-Reply-To: <20171211163243.GR7829@linux.vnet.ibm.com>
References: <1512728023-37977-1-git-send-email-lianglihao@huawei.com>
 <20171211163243.GR7829@linux.vnet.ibm.com>
Message-ID: <dc074d51-ea4c-0bd0-1bfe-9844fd5d7994@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Many thanks for your helpful comments! I have addressed all of them in a new version of the patch, which is sent out in a separate email.

If you have further comments, please let me know.

Best regards,
Lihao.

On 2017/12/12 0:32, Paul E. McKenney wrote:
> On Fri, Dec 08, 2017 at 06:13:43PM +0800, lianglihao at huawei.com wrote:
>> From: Lihao Liang <lianglihao@huawei.com>
>>
>> This commit adds support of the qemu command qemu-system-aarch64
>> to rcutorture. Use the following command to run:
>>
>>   ./kvm.sh --qemu-cmd qemu-system-aarch64
>>
>> Signed-off-by: Lihao Liang <lianglihao@huawei.com>
> 
> Nice!!!  Getting ARM support for rcutorture has been on my todo list
> for some time!
> 
> A few questions and comments below.
> 
> Feedback from ARM experts also welcome!
> 
> 							Thanx, Paul
> 
>> ---
>>
>> The max CPUs supported by qemu machine 'virt' is 8 so the value of
>> CONFIG_NR_CPUS in some test configuration files needs to be adjusted.
>>
>>  tools/testing/selftests/rcutorture/bin/functions.sh | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
>> index 07a1377..5ffe4fe 100644
>> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
>> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
>> @@ -136,6 +136,9 @@ identify_boot_image () {
>>  		qemu-system-x86_64|qemu-system-i386)
>>  			echo arch/x86/boot/bzImage
>>  			;;
>> +		qemu-system-aarch64)
>> +			echo arch/arm64/boot/Image
>> +			;;
>>  		*)
>>  			echo vmlinux
>>  			;;
> 
> Is it possible to automatically select ARM based on the kernel binary?
> See the identify_qemu function for how this is done for i386, x86_64,
> and PowerPC.  Can an "elif" be added for ARM?
> 
>> @@ -185,7 +188,14 @@ identify_qemu_append () {
>>  	then
>>  		echo root=/dev/sda
>>  	else
>> -		echo console=ttyS0
>> +		case "$1" in
>> +		qemu-system-aarch64)
>> +			echo console=ttyAMA0
>> +			;;
>> +		*)
>> +			echo console=ttyS0
>> +			;;
>> +		esac
>>  	fi
>>  }
> 
> This approach is going to result in very ugly nesting if support is
> added for additional CPU families.  How about something like this?
> 
> identify_qemu_append () {
> 	local console=ttyS0
> 
> 	case "$1" in
> 	qemu-system-x86_64|qemu-system-i386)
> 		echo noapic selinux=0 initcall_debug debug
> 		;;
> 	qemu-system-aarch64)
> 		console=ttyAMA0
> 		;;
> 	esac
> 	if test -n "$TORTURE_QEMU_INTERACTIVE"
> 	then
> 		echo root=/dev/sda
> 	else
> 		echo console=$console
> 	fi
> }
> 
>> @@ -197,6 +207,9 @@ identify_qemu_args () {
>>  	case "$1" in
>>  	qemu-system-x86_64|qemu-system-i386)
>>  		;;
>> +	qemu-system-aarch64)
>> +		echo -M virt -cpu host
>> +		;;
>>  	qemu-system-ppc64)
>>  		echo -enable-kvm -M pseries -nodefaults
>>  		echo -device spapr-vscsi
>> @@ -257,6 +270,9 @@ specify_qemu_cpus () {
>>  		qemu-system-x86_64|qemu-system-i386)
> 
> How about the following instead, eliminating the need for an additional
> case?
> 
>  		qemu-system-x86_64|qemu-system-i386!qemu-system-aarch64)
> 
>>  			echo $2 -smp $3
>>  			;;
>> +		qemu-system-aarch64)
>> +			echo $2 -smp $3
>> +			;;
>>  		qemu-system-ppc64)
>>  			nt="`lscpu | grep '^NUMA node0' | sed -e 's/^[^,]*,\([0-9]*\),.*$/\1/'`"
>>  			echo $2 -smp cores=`expr \( $3 + $nt - 1 \) / $nt`,threads=$nt
>> -- 
>> 2.7.4
>>
> 
> 
> .
> 
