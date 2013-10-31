From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 31 Oct 2013 17:02:13 +0900
Subject: [PATCH] ARM: shmobile: Include all 2 GiB of memory on APE6EVM
In-Reply-To: <20131031042035.GG1603@verge.net.au>
References: <20131031031549.15985.23547.sendpatchset@w520>
 <20131031042035.GG1603@verge.net.au>
Message-ID: <CANqRtoSW6jFX3pa94ZBgrKkvx5YNKqgxVSsYkSxMP_btcxFh7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Oct 31, 2013 at 1:20 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Oct 31, 2013 at 12:15:49PM +0900, Magnus Damm wrote:
>> From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
>>
>> Add 1GiB of DRAM at 0x2_0000_0000 to support the full 2GiB
>> of APE6EVM system memory.
>>
>> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>>  For correct run time operation regardless of kernel configuration
>>  ARM patches 7863/1 and 7864/1 are needed.
>
> I take it that I should wait for those patches before applying this one.

That's probably a good idea. RMK has applied them to "git-curr", so I
suppose they are queued up for something at least:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7863/1

> With those two patches and this one applied on top of
> renesas-devel-v3.12-rc7-20131030 I was able to successfully
> boot an ape6evm board. But /proc/meminfo still indicates only 1Gb of
> memory. What am I missing.

You probably need to enable HIGHMEM and LPAE to be able to access to
all memory. Same thing on Lager, to get the full 4GiB you need to
select those in your kernel configuration too.

Please note that having memory located on 64-bit addresses may break
some drivers doing bus mastering or using the DMAC. These drivers need
to be fixed both with short term DMA zone workarounds and proper
64-bit address support whenever possible.

So if I could suggest a policy then having LPAE=n in defconfig for the
C board code for default stable operation. This together with LPAE=y
in the case of DT reference and/or Multiplatform where we can be a bit
more experimental. I don't care enough to send defconfig patches, but
if some issue comes up then perhaps adjusting the defconfig to disable
LPAE may work well as a workaround.

Cheers,

/ magnus
