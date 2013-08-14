From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Aug 2013 11:22:17 +0100
Subject: [PATCH] KVM: ARM: ignore guest L2 cache control SMCs on Highbank
 and OMAP
In-Reply-To: <520B5049.3020803@linaro.org>
References: <1376472125-23350-1-git-send-email-andre.przywara@calxeda.com>
 <c8a1944576151990b3315183acee02be@www.loen.fr> <520B5049.3020803@linaro.org>
Message-ID: <d1af57b665e733f0102f86d44f5c1ae2@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-08-14 10:39, Andre Przywara wrote:
> On 08/14/2013 11:32 AM, Marc Zyngier wrote:
>> On 2013-08-14 10:22, Andre Przywara wrote:
>>> Guest kernels with CONFIG_L2X0 set (for instance Highbank or OMAP4)
>>> will trigger SMCs to handle the L2 cache controller (PL310).
>>> This will currently inject #UNDEFs and eventually stop the guest.
>>>
>>> We don't need explicit L2 cache controller handling on A15s 
>>> anymore,
>>> so it is safe to simply ignore these calls and proceed with the 
>>> next
>>> instruction.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@calxeda.com>
>>
>> Hold on.
>>
>> Are you trying to run A9 guests on KVM? Sorry, but that's not a
>> supported mode of operation just yet.
>
> No, I don't. I just run guests with kernels that would support A9
> also. If you select Highbank in your .config, you will get CACHE_L2X0
> and the kernel will do SMCs - regardless of the CPU you are running
> on. Those SMCs are ignored by the firmware on Midway.
>
> I agree that the proper solution would be to detect at run-time in
> the (guest) kernel whether you actually need the PL310 handling, but
> for the time being and to support older kernels we will need this 
> fix.
>
> For me this fixes "qemu -machine midway --enable-kvm".

I understand that this fixes an issue, but I'd rather see either the 
guest kernel being fixed, or some decent framework for SMC handling in 
KVM (potentially leaving it to platform emulation to handle it).

Testing random registers won't cut it, I'm afraid.

         M.
-- 
Fast, cheap, reliable. Pick two.
