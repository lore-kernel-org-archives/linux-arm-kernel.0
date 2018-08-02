From: matthew.hart@linaro.org (Matt Hart)
Date: Thu, 2 Aug 2018 18:52:58 +0100
Subject: next/master boot: 141 boots: 9 failed,
 131 passed with 1 offline (next-20180802)
In-Reply-To: <CAKv+Gu9wugcvt4p9L=kv8dNvY5Cp3fEXFpUu_yNcir1dTpHgeQ@mail.gmail.com>
References: <5b6334da.1c69fb81.5b234.a137@mx.google.com>
 <20180802171404.GQ9117@sirena.org.uk>
 <CAKv+Gu9wugcvt4p9L=kv8dNvY5Cp3fEXFpUu_yNcir1dTpHgeQ@mail.gmail.com>
Message-ID: <CAH+k93Hc4RnTYi49SFBuN3tw6QGmF98SugnonagxJZ_iHgQqzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 August 2018 at 18:46, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 2 August 2018 at 19:14, Mark Brown <broonie@kernel.org> wrote:
>> On Thu, Aug 02, 2018 at 09:44:10AM -0700, kernelci.org bot wrote:
>>
>> Today's -next fails to boot on SynQuacer when booted with ACPI:
>>
>>> arm64:
>>>     defconfig:
>>>         synquacer-acpi:
>>>             lab-mhart: new failure (last pass: next-20180801)
>>
>> The boot seems to hang after enumerating the disks:
>>
>> 13:17:59.325408  [    7.416795] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>> 13:17:59.331425  [    7.423625] ata1.00: ATA-10: WDC WD10EZEX-22MFCA0, 01.01A01, max UDMA/133
>> 13:17:59.337401  [    7.430415] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
>> 13:17:59.343411  [    7.438058] ata1.00: configured for UDMA/133
>> 13:17:59.349409  [    7.442752] scsi 0:0:0:0: Direct-Access     ATA      WDC WD10EZEX-22M 1A01 PQ: 0 ANSI: 5
>> 13:17:59.360397  [    7.451387] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
>> 13:17:59.366427  [    7.459059] sd 0:0:0:0: [sda] 4096-byte physical blocks
>> 13:17:59.367152  [    7.464324] sd 0:0:0:0: [sda] Write Protect is off
>> 13:17:59.377343  [    7.469161] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>> 13:17:59.431420  [    7.526763]  sda: sda1 sda2 sda3
>> 13:17:59.435383  [    7.531608] sd 0:0:0:0: [sda] Attached SCSI disk
>> 13:17:59.671358  [    7.763087] ata2: SATA link down (SStatus 0 SControl 300)
>>
>> In a working boot like yesterday's we then see networking output which
>> seems to be missing here:
>>
>> 10:32:34.187752  [    8.362173] netsec SCX0001:00 eth0: Link is Down
>> 10:32:38.325575  [   12.463251] netsec SCX0001:00 eth0: Link is Up - 1Gbps/Full - flow control rx/tx
>> 10:32:38.345614  [   12.485944] IP-Config: Complete:
>>
>> All the info we have including full logs is here:
>>
>>    https://kernelci.org/boot/id/5b63052b59b5143ca896bab8/
>>
>> and I kicked off a bisect:
>>
>>    https://ci.kernelci.org/job/lava-bisect/5624/
>>
>> which will take a while to run, I'll report back tomorrow.
>>
>> (you can only see if you have an account, sorry - we can probably
>> sort you out with a login if you like, or people on #kernelci should be
>> able to at least look at the results for you.)
>
> I had a quick look at the delta between yesterday's and today's next,
> and the only thing that really stands out are the anon VMA changes in
> mainline.
>
> It would be useful to compare with synquacer-dtb, though. Is that still online?

It's been hard to keep that Synquacer machine online as the serial
just quietly drops out. It's still connected over USB but no output
comes from the board. If I pull the usb serial and reconnect it, it
all works fine for a few days until it stops again. I'm planning to
put an RS232 convertor in the back to give a normal serial port and
see if that improves it.

> _______________________________________________
> Kernel-build-reports mailing list
> Kernel-build-reports at lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/kernel-build-reports
