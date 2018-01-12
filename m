From: lianglihao@huawei.com (Lihao Liang)
Date: Fri, 12 Jan 2018 18:23:42 +0800
Subject: [PATCH v2] rcutorture: Add basic ARM64 support to run scripts
In-Reply-To: <20171218233155.GZ7829@linux.vnet.ibm.com>
References: <1513070365-13436-1-git-send-email-lianglihao@huawei.com>
 <20171218233155.GZ7829@linux.vnet.ibm.com>
Message-ID: <abe6ba11-a7f0-0e8a-e57c-58dc77f7c07a@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 2017/12/19 7:31, Paul E. McKenney wrote:
> On Tue, Dec 12, 2017 at 05:19:25PM +0800, lianglihao at huawei.com wrote:
>> From: Lihao Liang <lianglihao@huawei.com>
>>
>> This commit adds support of the qemu command qemu-system-aarch64
>> to rcutorture.
>>
>> Signed-off-by: Lihao Liang <lianglihao@huawei.com>
> 
> Queued for further review and testing, thank you!
> 
> (This one has been on my list for quite some time.)
> 
> 							Thanx, Paul
> 
>> ---
>> This commit is against RCU's git tree rcu/dev branch
>>
>> commit 505b61b2ec1d ("EXP: rcu: Add debugging info to other assertion")
>>
>> Note that the max CPUs supported by qemu machine 'virt' is 8 so the value of
>> CONFIG_NR_CPUS in some test configuration files needs to be adjusted.
>>
>>  tools/testing/selftests/rcutorture/bin/functions.sh | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
>> index 07a1377..0541d10 100644
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
>> @@ -158,6 +161,9 @@ identify_qemu () {
>>  	elif echo $u | grep -q "Intel 80386"
>>  	then
>>  		echo qemu-system-i386
>> +	elif echo $u | grep -q aarch64
>> +	then
>> +		echo qemu-system-aarch64
>>  	elif uname -a | grep -q ppc64
>>  	then
>>  		echo qemu-system-ppc64
>> @@ -176,16 +182,20 @@ identify_qemu () {
>>  # Output arguments for the qemu "-append" string based on CPU type
>>  # and the TORTURE_QEMU_INTERACTIVE environment variable.
>>  identify_qemu_append () {
>> +	local console=ttyS0
>>  	case "$1" in
>>  	qemu-system-x86_64|qemu-system-i386)
>>  		echo noapic selinux=0 initcall_debug debug
>>  		;;
>> +	qemu-system-aarch64)
>> +		console=ttyAMA0
>> +		;;
>>  	esac
>>  	if test -n "$TORTURE_QEMU_INTERACTIVE"
>>  	then
>>  		echo root=/dev/sda
>>  	else
>> -		echo console=ttyS0
>> +		echo console=$console
>>  	fi
>>  }
>>
>> @@ -197,6 +207,9 @@ identify_qemu_args () {
>>  	case "$1" in
>>  	qemu-system-x86_64|qemu-system-i386)
>>  		;;
>> +	qemu-system-aarch64)
>> +		echo -M virt -cpu host

The qemu option "-M virt" only supports maximum 8 CPUs. We can lift this limitation by adding "gic-version=host" to it, which allows qemu to use the maximum CPU number supported by the actual hardware.

I have sent you a new version in a separate email.

Best,
Lihao.

>> +		;;
>>  	qemu-system-ppc64)
>>  		echo -enable-kvm -M pseries -nodefaults
>>  		echo -device spapr-vscsi
>> @@ -254,7 +267,7 @@ specify_qemu_cpus () {
>>  		echo $2
>>  	else
>>  		case "$1" in
>> -		qemu-system-x86_64|qemu-system-i386)
>> +		qemu-system-x86_64|qemu-system-i386|qemu-system-aarch64)
>>  			echo $2 -smp $3
>>  			;;
>>  		qemu-system-ppc64)
>> -- 
>> 2.7.4
>>
> 
> 
> .
> 
