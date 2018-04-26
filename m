From: james.morse@arm.com (James Morse)
Date: Thu, 26 Apr 2018 12:00:06 +0100
Subject: arm64: W+X mapping check failures
In-Reply-To: <20180425144727.GA18651@hc>
References: <20180425133704.GA6474@hc>
 <20180425135702.zvt4vjoegqblgr7c@lakrids.cambridge.arm.com>
 <20180425144727.GA18651@hc>
Message-ID: <46a204a8-491a-a7f0-0989-cc223ee78bc2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 25/04/18 15:47, Jan Glauber wrote:
> On Wed, Apr 25, 2018 at 02:57:02PM +0100, Mark Rutland wrote:
>> On Wed, Apr 25, 2018 at 03:37:04PM +0200, Jan Glauber wrote:
>>> The reported W+X mappings are gone after the boot is finished. The addresses
>>> all belong to .init.* sections of the first loaded kernel modules.
>>
>> I'm afraid I haven't tried loading modules before getting to userspace,
>> and I'm not sure what I'd need to set up to test that.
> 
> Not much I guess, initramfs with early modules. For instance encrypted
> root should be a possible testcase. In my tests it was always cryptd and
> dependent modules (crypto_simd, aes_neon_blk, aes_neon_bs) that
> triggered the issue.

I've used "elevator=deadline" on the kernel cmdline as something that takes less
setup. This will cause deadline-iosched.ko to be loaded during
kernel_init_freeable() if its not built-in.

dmesg shows:
| [   10.195409] I/O scheduler deadline not found

| [   10.204365] scsi 4:0:0:0: Direct-Access     ATA      WDC WD5000AAKX-0
| [   10.222301] sd 4:0:0:0: [sda] 976773168 512-byte logical blocks:
| [   10.237494] sd 4:0:0:0: [sda] Write Protect is off
| [   10.247130] sd 4:0:0:0: [sda] Mode Sense: 00 3a 00 00
| [   10.257365] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled,
| [   10.336133]  sda: sda1 sda2 sda3 sda4 sda5

| [   11.723286] io scheduler deadline registered (default)
| [   11.738017] Freeing unused kernel memory: 5824K



Thanks,

James
