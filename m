From: james.morse@arm.com (James Morse)
Date: Fri, 25 Nov 2016 18:30:49 +0000
Subject: [PATCH 0/2] kexec-tools: arm64: Add dcache enabling facility
In-Reply-To: <8415f028-f42e-2980-9b60-e85aae046d02@infradead.org>
References: <cover.1479788404.git.panand@redhat.com>
 <8415f028-f42e-2980-9b60-e85aae046d02@infradead.org>
Message-ID: <58388359.4090002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 22/11/16 18:56, Geoff Levand wrote:
> On 11/21/2016 08:32 PM, Pratyush Anand wrote:
>> It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
>> is around 13MB and initramfs is around 30MB. It takes more than 20 second
>> even when we have -O2 optimization enabled. However, if dcache is enabled
>> during purgatory execution then, it takes just a second in SHA verification.
> 
> As I had mentioned in another thread, I think -O2 optimization is
> sufficient considering the complexity of the code needed to enable
> the dcache.  Integrity checking is only needed for crash dump
> support.  If the crash reboot takes an extra 20 seconds does it
> matter?
> 
> For the re-boot of a stable system where the new kernel is loaded
> then immediately kexec'ed into integrity checking is not needed.

I agree.
If purgatory detects corruption in the new-kernel or initramfs all it can do is
spin in a loop. If we are very lucky in could print a debug message to the
serial console. If the planets line up, someone might see this message.

If we validate the checksum in the kernel kexec core code we can possibly fail
the syscall and return to a running system. We can use EFI runtime services to
try and reboot, or print a message to somewhere that might get seen such as
syslog or netconsole.

I agree kdump is different but I don't think 'we crashed' is performance critical.


Thanks,

James
