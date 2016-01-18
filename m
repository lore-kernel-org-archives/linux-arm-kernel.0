From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 18 Jan 2016 19:26:04 +0900
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <20160115201601.GR3262@leverpostej>
References: <cover.1452884156.git.geoff@infradead.org>
 <fb4506943bbaed8b0657ed367ebd57e4064d57ed.1452884156.git.geoff@infradead.org>
 <20160115201601.GR3262@leverpostej>
Message-ID: <569CBDBC.5050500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2016 05:16 AM, Mark Rutland wrote:
> On Fri, Jan 15, 2016 at 07:18:38PM +0000, Geoff Levand wrote:
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>
>> This patch adds arch specific descriptions about kdump usage on arm64
>> to kdump.txt.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   Documentation/kdump/kdump.txt | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
>> index bc4bd5a..36cf978 100644
>> --- a/Documentation/kdump/kdump.txt
>> +++ b/Documentation/kdump/kdump.txt
>> @@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
>>   a remote system.
>>
>>   Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
>> -s390x and arm architectures.
>> +s390x, arm and arm64 architectures.
>>
>>   When the system kernel boots, it reserves a small section of memory for
>>   the dump-capture kernel. This ensures that ongoing Direct Memory Access
>> @@ -249,6 +249,20 @@ Dump-capture kernel config options (Arch Dependent, arm)
>>
>>       AUTO_ZRELADDR=y
>>
>> +Dump-capture kernel config options (Arch Dependent, arm64)
>> +----------------------------------------------------------
>> +
>> +1) The maximum memory size on the dump-capture kernel must be limited by
>> +   specifying:
>> +
>> +   mem=X[MG]
>> +
>> +   where X should be less than or equal to the size in "crashkernel="
>> +   boot parameter. Kexec-tools will automatically add this.
>
>
> This is extremely fragile, and will trivially fail when the kernel can
> be loaded anywhere (see [1]).

As I said before, this restriction also exists on arm, but I understand
that recent Ard's patches break it.

> We must explicitly describe the set of regions the crash kernel may use
> (i.e. we need base and size). NAK in the absence of that.

There seem to exist several approaches:
(a) use a device-tree property, "linux,usable-memory", in addition to "reg"
     under "memory" node
(b) use a kernel's early parameter, "memmap=nn[@#$]ss"

Power PC takes (a), while this does not work on efi-started kernel
because dtb has no "memory" nodes under efi.
X86 takes (b). If we take this, we will need to overwrite a weak
early_init_dt_add_memory().
(I thought that this approach was not smart as we have three different
ways to specify memory regions, dtb, efi and this kernel parameter.)

Do you have any other ideas?

Thanks,
-Takahiro AKASHI


> Thanks,
> Mark.
>
>> +
>> +2) Currently, kvm will not be enabled on the dump-capture kernel even
>> +   if it is configured.
>> +
>>   Extended crashkernel syntax
>>   ===========================
>>
>> @@ -312,6 +326,8 @@ Boot into System Kernel
>>      any space below the alignment point may be overwritten by the dump-capture kernel,
>>      which means it is possible that the vmcore is not that precise as expected.
>>
>> +   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
>> +   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
>>
>>   Load the Dump-capture Kernel
>>   ============================
>> @@ -334,6 +350,8 @@ For s390x:
>>   	- Use image or bzImage
>>   For arm:
>>   	- Use zImage
>> +For arm64:
>> +	- Use vmlinux or Image
>>
>>   If you are using a uncompressed vmlinux image then use following command
>>   to load dump-capture kernel.
>> @@ -377,6 +395,9 @@ For s390x:
>>   For arm:
>>   	"1 maxcpus=1 reset_devices"
>>
>> +For arm64:
>> +	"1 mem=X[MG] maxcpus=1 reset_devices"
>> +
>>   Notes on loading the dump-capture kernel:
>>
>>   * By default, the ELF headers are stored in ELF64 format to support
>> --
>> 2.5.0
>>
>>
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/398527.html
>
