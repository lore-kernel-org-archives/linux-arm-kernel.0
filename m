From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Tue, 18 Jul 2017 11:08:10 +0000
Subject: [PATCH 6/7] staging: fsl-mc: rewrite mc command send/receive to
 work on 32-bits
In-Reply-To: <CAK8P3a3e+Gv2bdHKkRdNVp1e2-Z6j351cudLU4fuH2aZ8CSwmQ@mail.gmail.com>
References: <20170717132646.3020-1-laurentiu.tudor@nxp.com>
 <20170717132646.3020-7-laurentiu.tudor@nxp.com>
 <CAK8P3a3KDh=MgfjG+sKNqcrQwq1yf-DgQN0=HigPaPYYJq0Uug@mail.gmail.com>
 <596CC912.3020709@nxp.com>
 <CAK8P3a3e+Gv2bdHKkRdNVp1e2-Z6j351cudLU4fuH2aZ8CSwmQ@mail.gmail.com>
Message-ID: <596DEC19.6060301@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/17/2017 06:00 PM, Arnd Bergmann wrote:
> On Mon, Jul 17, 2017 at 4:27 PM, Laurentiu Tudor
> <laurentiu.tudor@nxp.com> wrote:
>> Hi Arnd,
>>
>> On 07/17/2017 04:45 PM, Arnd Bergmann wrote:
>>> On Mon, Jul 17, 2017 at 3:26 PM,  <laurentiu.tudor@nxp.com> wrote:
>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>
>>>> Split the 64-bit accesses in 32-bit accesses because there's no real
>>>> constrain in MC to do only atomic 64-bit. There's only one place
>>>> where ordering is important: when writing the MC command header the
>>>> first 32-bit part of the header must be written last.
>>>> We do this switch in order to allow compiling the driver on 32-bit.
>>>>
>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>> ---
>>>>    drivers/staging/fsl-mc/bus/mc-sys.c | 31 ++++++++++++-------------------
>>>>    1 file changed, 12 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/staging/fsl-mc/bus/mc-sys.c
>>>> index 195d9f3..dd2828e 100644
>>>> --- a/drivers/staging/fsl-mc/bus/mc-sys.c
>>>> +++ b/drivers/staging/fsl-mc/bus/mc-sys.c
>>>> @@ -124,14 +124,15 @@ static inline void mc_write_command(struct mc_command __iomem *portal,
>>>>    {
>>>>           int i;
>>>>
>>>> -       /* copy command parameters into the portal */
>>>> -       for (i = 0; i < MC_CMD_NUM_OF_PARAMS; i++)
>>>> -               __raw_writeq(cmd->params[i], &portal->params[i]);
>>>> -       /* ensure command params are committed before submitting it */
>>>> -       wmb();
>>>> -
>>>> -       /* submit the command by writing the header */
>>>> -       __raw_writeq(cmd->header, &portal->header);
>>>> +       /*
>>>> +        * copy command parameters into the portal. Final write
>>>> +        * triggers the submission of the command.
>>>> +        */
>>>> +       for (i = sizeof(struct mc_command) / sizeof(u32) - 1; i >= 0; i--) {
>>>> +               __raw_writel(((u32 *)cmd)[i], &((u32 *)portal)[i]);
>>>> +               /* ensure command params are committed before submitting it */
>>>> +               wmb();
>>>> +       }
>>>>    }
>>>
>>> What is the byte order requirement on this buffer?
>>
>> Endianness is handled by the callers so this function must leave
>> the binary blob intact.
>
> Got it, the endianess looks correct indeed.
>
>>> If this is a byte string
>>> rather than individual registers, you should probably just use
>>> memcpy_toio()
>>
>> It's a header followed by an opaque command. The protocol for queueing a
>> command says that the first 32-bit half of the header must be written
>> last, this triggering the command handling in the MC.
>
> Strictly speaking the __raw_writel() won't guarantee that the
> data is written as a single word, the compiler might decide to
> split it up into byte-sized writes if it believes the destination pointer
> is unaligned and the CPU has no efficient writes.
>
> I think this cannot happen on arm or powerpc, as we go through
> inline assembly for the store, but it's not completely portable.

Should i worry about portability? Slim changes that this driver
will ever run on anything else other than ARM & ARM64.
My current goal was just to make it compile on other arches.

> Before your patch, both the compiler and the CPU could also
> reorder the stores in theory (but normally won't), but the wmb()
> will prevent that now.

Ok, thanks for the info.

>>> but if these are separate registers, then using the
>>> __raw_* accessors is still wrong, at least on kernels that have a
>>> different byteorder from the hardware.
>>
>> As mentioned above, endianness is handled by the caller. This function
>> takes raw data and must leave it unchanged.
>>
>>> Also, are you sure that adding those six extra barriers has no
>>> performance impact?
>>
>> This is a slow interface used in slow paths, so i don't think those
>> extra barriers will have any performance impact.
>
> Ok.
>
> One other problem remains: most developers looking at this
> code like Robin and me will immediately think there might be
> an endianess bug here. As this is a slow path, how about
> using an explicit conversion using
>
>       writeq(le64_to_cpup(buffer), pointer);

Sure, sounds perfect. I'll do that in the next respin.

---
Thanks & Best Regards, Laurentiu
