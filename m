From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 14 Oct 2015 13:18:46 +0900
Subject: [PATCH 3/3] ARM: dts: exynos5422-odroidxu3: Added UHS-I bus speed
 support
In-Reply-To: <CANAwSgS=AdOKre79PAP8EQfhvZtMrWuMWPodoPr3_Sq=TWJwbw@mail.gmail.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-3-git-send-email-linux.amoon@gmail.com>
 <561B48B7.1040201@samsung.com>
 <CANAwSgSLFviT4ZNXTYwxYs2pbrr9ozJmPMauhgRPO0556Rsr_g@mail.gmail.com>
 <561C4CEE.3050905@samsung.com>
 <CANAwSgRJ+5O-x61K9E_AxTZWQy3jJrKF5MiLtWRdUU29CCfa-Q@mail.gmail.com>
 <561C7DF1.6000609@samsung.com>
 <CANAwSgRBzFqHB98wSQnQu-ggGqRT2H6wC415wULXVhPg0uw_3A@mail.gmail.com>
 <561D9ACE.6050103@samsung.com>
 <CANAwSgS=AdOKre79PAP8EQfhvZtMrWuMWPodoPr3_Sq=TWJwbw@mail.gmail.com>
Message-ID: <561DD7A6.5010607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.10.2015 12:58, Anand Moon wrote:
> hi Krzysztof,
> 
> On 14 October 2015 at 05:29, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> On 14.10.2015 01:27, Anand Moon wrote:
>>> Hi Krzysztof,
>>>
>>> On 13 October 2015 at 09:13, Krzysztof Kozlowski
>>> <k.kozlowski@samsung.com> wrote:
>>>>
>>>> On 13.10.2015 12:08, Anand Moon wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> On 13 October 2015 at 05:44, Krzysztof Kozlowski
>>>>> <k.kozlowski@samsung.com> wrote:
>>>>>> On 13.10.2015 00:32, Anand Moon wrote:
>>>>>>> Hi Krzysztof,
>>>>>>>
>>>>>>> On 12 October 2015 at 11:14, Krzysztof Kozlowski
>>>>>>> <k.kozlowski@samsung.com> wrote:
>>>>>>>> On 12.10.2015 00:46, Anand Moon wrote:
>>>>>>>>> Added support for UHS-I bus speed 50MB/s (SDR50, DDR50) 104MB/s (SDR104)
>>>>>>>>
>>>>>>>> This description is not entirely correct. The MMC driver already
>>>>>>>> supports these UHS speeds (you did not any code) so you rather enabled
>>>>>>>> it (description of bindings says "is supported").
>>>>>>>>
>>>>>>>> You mentioned DDR50 but I don't see respective property below.
>>>>>>>>
>>>>>>>> How do you know that these modes are really supported? I don't know. Can
>>>>>>>> you convince me?
>>>>>>>
>>>>>>> Setting this DDR50 capability give me this error. That's the reason to
>>>>>>> drop this capability.
>>>>>>
>>>>>> But you mentioned it in commit message! "Added support for UHS-I ...
>>>>>> (DDR50)"
>>>>>>
>>>>>> In the same time dropping DDR50 is not an sufficient proof that "SDR50
>>>>>> and SDR104 are really supported".
>>>>>>
>>>>>
>>>>> These changes are related to the microSD card capabilities.
>>>>> So SDR50 have better frequency over DDR50. On the same Sandisk card.
>>>>>
>>>>> When the card select the capability for DDR50
>>>>> ---------------------------------------------------
>>>>> [    4.001477] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
>>>>> req 50000000Hz, actual 50000000HZ div = 0)
>>>>> [    4.001604] mmc1: new ultra high speed DDR50 SDHC card at address aaaa
>>>>> [    4.004505] mmcblk0: mmc1:aaaa SL32G 29.7 GiB
>>>>> [    4.009179] mmcblk0: error -110 sending status command, retrying
>>>>> [    4.009271] mmcblk0: error -115 sending stop command, original cmd
>>>>> response 0x900, card status 0x900
>>>>> [    4.009275] mmcblk0: error -84 transferring data, sector 0, nr 8,
>>>>> cmd response 0x900, card status 0x0
>>>>> [    4.025563] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
>>>>> req 400000Hz, actual 396825HZ div = 63)
>>>>> [    4.067770] Console: switching to colour frame buffer device 274x77
>>>>> [    4.098782] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
>>>>> req 50000000Hz, actual 50000000HZ div = 0)
>>>>> [    4.099692] mmc1: tried to reset card
>>>>> [    4.101332]  mmcblk0: p1 p2
>>>>>
>>>>>
>>>>> When the card select the capability for SDR50
>>>>> ---------------------------------------------------------------------------------
>>>>> [ 2.439806] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req
>>>>> 100000000Hz, actual 100000000HZ div = 0)
>>>>> [ 2.449729] mmc1: new ultra high speed SDR50 SDHC card at address aaaa
>>>>> [ 2.455984] mmcblk0: mmc1:aaaa SL32G 29.7 GiB
>>>>> [ 2.461743] mmcblk0: p1 p2
>>>>>
>>>>> Which will relate to better read/write speed.
>>>>
>>>> Which is not an answer to my question. To none of my previous questions.
>>>>
>>>
>>> Basically UHS-I capability  (sd-uhs-sdr12, sd-uhs-sdr25, sd-uhs-sdr50,
>>> sd-uhs-sdr104) help tune speed supported for mmc
>>>
>>> I have tired to compare the speed on high speed UHS-I vs ultra high
>>> speed UHS-I using izone utility.
>>>
>>> [    2.572469] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
>>> req 50000000Hz, actual 50000000HZ div = 0)
>>> [    2.572609] mmc1: new high speed SDHC card at address aaaa
>>>
>>>       Command line used: ./iozone -L64 -S32 -azecwI -+n -r4k -r64k
>>> -r128k -s10M -i0 -i1 -i2 -f datafile -Rb out.xls
>>>         Output is in kBytes/sec
>>>         Time Resolution = 0.000001 seconds.
>>>         Processor cache size set to 32 kBytes.
>>>         Processor cache line size set to 64 bytes.
>>>         File stride size set to 17 * record size.
>>>                                                               random
>>>  random     bkwd    record    stride
>>>               kB  reclen    write  rewrite    read    reread    read
>>>   write     read   rewrite      read   fwrite frewrite    fread
>>> freread
>>>            10240       4     1631        0     6556        0     5538      982
>>>            10240      64     8828        0    18897        0    17994      303
>>>            10240     128     6269        0    20670        0    20128     1096
>>> ---------------------------------------------------------------------------------------------------------
>>> [    2.613761] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot
>>> req 100000000Hz, actual 100000000HZ div = 0)
>>> [    2.623573] mmc1: new ultra high speed SDR50 SDHC card at address aaaa
>>>
>>>         Command line used: ./iozone -L64 -S32 -azecwI -+n -r4k -r64k
>>> -r128k -s10M -i0 -i1 -i2 -f datafile -Rb out.xls
>>>         Output is in kBytes/sec
>>>         Time Resolution = 0.000001 seconds.
>>>         Processor cache size set to 32 kBytes.
>>>         Processor cache line size set to 64 bytes.
>>>         File stride size set to 17 * record size.
>>>                                                               random
>>>  random     bkwd    record    stride
>>>               kB  reclen    write  rewrite    read    reread    read
>>>   write     read   rewrite      read   fwrite frewrite    fread
>>> freread
>>>            10240       4     1809        0     7507        0     5233      859
>>>            10240      64    11622        0    31250        0    28072      516
>>>            10240     128     4320        0    34417        0    32509     1148
>>>
>>> My observation is that their slight increase in read/write operation.
>>>
>>> Hope I have tried to answer you query. If I am wrong please let me know.
>>
>> Nope, that did not answer my query. You gave some performance benchmarks
>> but my question was not about the speed of anything. The question is
>> (once again):
>> How do you know that these modes are really supported?
>>
>> You are marking the *host* as supporting these modes. Please provide
>> information that host supports them *really*, not by experimenting "oh,
>> it seems to work now, maybe it will work always".
>>
>> Usually vendors, if their products implement some kind of
>> specification/protocol, they mark the products as "compatible with XYZ" etc.
> 
> I found this link from hardkernel website which specify the interface support
> 
> http://www.hardkernel.com/main/products/prdt_info.php?g_code=G141578491347
> 
> Manufacturer Part Number : Sandisk SDSDQAD-016G
> Interface : UHS-1 SDR50
> 
> I don't know much internal specification of the Odroid XU3/XU4 Boards.
> 
> I am not sure if it will support host will sd-uhs-sdr104, but it will
> be compatible for sd-uhs-sdr12, sd-uhs-sdr25, sd-uhs-sdr50.

I can't find how this proofs anything.

You can sell an UHS-II card labelled "for ODROID-XU3 and XU4" and it
will work fine on Odroid-XU3. Does it mean that Odroid-XU3 supports UHS-II?

That UHS-II card will work even on 10-year camera! Of course not in UHS
mode... Does it mean that this 10-year old camera supports UHS-II? Of
course not because it will work in some HS mode (or even pre-HS).

You can label any SD card as "for Odroid XU3" because any card will work...

Best regards,
Krzysztof
