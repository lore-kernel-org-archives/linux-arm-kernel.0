From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Thu, 29 Mar 2012 13:05:24 +0530
Subject: [PATCH 1/3] OMAP2+: UART: Remove cpu checks for populating errata
 flags
In-Reply-To: <4F733FC4.9010506@ti.com>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
 <1332325501-10467-2-git-send-email-govindraj.raja@ti.com>
 <4F722C63.9080900@ti.com>
 <CAMrsUdKfsoks4fB4GhrRcEur8niJsaWuYGE34+j5Bk6u2XiZQQ@mail.gmail.com>
 <4F733FC4.9010506@ti.com>
Message-ID: <CAMrsUdKAAcc=tnC_vGRosEsqUmJBVaDQ9T=n898+9n30QwsSag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 10:13 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> Hi Govindraj,
>
>
> On 3/28/2012 6:09, Raja, Govindraj wrote:
>>
>> On Wed, Mar 28, 2012 at 2:38 AM, Jon Hunter<jon-hunter@ti.com> ?wrote:
>>>
>>> Hi Govindraj,
>>>
>>>

[...]

>>>> + ? ? ? u32 mvr, scheme;
>>>> + ? ? ? u16 revision, major, minor;
>>>> +
>>>> + ? ? ? mvr = serial_in(up, UART_OMAP_MVER);
>>>> +
>>>> + ? ? ? /* Check revision register scheme */
>>>> + ? ? ? scheme = mvr& ? ?(0x03<< ? ?30);
>>>> + ? ? ? scheme>>= 30;
>>>
>>>
>>>
>>> Minor nit-pick, why not ...
>>>
>>> ? ? ? ?scheme = mvr>> ?30;
>>>
>>
>> yes will correct it.
>
>
> Thinking some more, could be better to add some #defines for
> OMAP_MVR_VERSION_MASK/SHIFT here.
>

Yes sure.

>
>>>
>>>> + ? ? ? switch (scheme) {
>>>> + ? ? ? case 0: /* Legacy Scheme: OMAP2/3 */
>>>> + ? ? ? ? ? ? ? /* MINOR_REV[0:4], MAJOR_REV[4:7] */
>>>
>>>
>>>
>>> This scheme is also true from OMAP1 devices. Maybe we could include in
>>> the
>>> comment.
>>
>>
>> No omap1 from $SUBJECT also reason,
>>
>> mach-omap1/serial.c => ?8250.c
>> mach-omap2/serial.c => ?omap-serial.c
>
>
> Got it! Thanks.
>
>>>> + ? ? ? ? ? ? ? major = (mvr& ? ?0xf0)>> ? ?4;
>>>> + ? ? ? ? ? ? ? minor = (mvr& ? ?0x0f);
>>>>
>>>> + ? ? ? ? ? ? ? break;
>>>> + ? ? ? case 1:
>>>> + ? ? ? ? ? ? ? /* New Scheme: OMAP4+ */
>>>> + ? ? ? ? ? ? ? /* MINOR_REV[0:5], MAJOR_REV[8:10] */
>>>> + ? ? ? ? ? ? ? major = (mvr& ? ?0x7<< ? ?8)>> ? ?8;
>>>
>>>
>>>
>>> Nit-pick ...
>>>
>>> ? ? ? ?major = (mvr>> ?8)& ?0x7;
>>
>>
>> yes fine will correct this.
>
>
> May be we should add #defines here to for OMAP_UART_MVR1_MAJ_MASK/SHIFT,
> OMAP_UART_MVR1_MIN_MASK/SHIFT, OMAP_UART_MVR2_MAJ_MASK/SHIFT and
> OMAP_UART_MVR2_MIN_MASK/SHIFT.
>

okay will add this.

--
Thanks,
Govindraj.R
