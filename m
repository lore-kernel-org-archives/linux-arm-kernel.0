From: lho@apm.com (Loc Ho)
Date: Tue, 14 Jan 2014 08:21:28 -0800
Subject: [PATCH v8 3/4] ata: Add APM X-Gene SoC SATA host controller driver
In-Reply-To: <20140114160419.GI12131@htj.dyndns.org>
References: <1389031922-4309-3-git-send-email-lho@apm.com>
 <1389031922-4309-4-git-send-email-lho@apm.com>
 <52D052F9.8050703@redhat.com>
 <20140111193104.GD3257@mtj.dyndns.org>
 <6EB44142-06DA-4C9D-8999-CFA9EE30E03D@apm.com>
 <20140112114958.GA8509@mtj.dyndns.org>
 <CAPw-ZTmfKfPY3DRfJT6FQP78ULwfcjGG76cNfr9yk7UMdrO4wg@mail.gmail.com>
 <20140113160843.GB29053@htj.dyndns.org>
 <CAPw-ZT=A=c9-3BfP-LoDBXByQqfvATpAdS4NPPWB9+R1+GHfDA@mail.gmail.com>
 <20140114160312.GH12131@htj.dyndns.org>
 <20140114160419.GI12131@htj.dyndns.org>
Message-ID: <CAPw-ZTmn6JiDku=vz=m9v5MNuFrK_-d0ehU_88drCYGHM8Wv=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


>> > As mentioned, the flush requires immediately after reading the CI.
>> > Otherwise, there is still an chance that the command is completed and
>> > the OS notified the upper layer while the data is still in flight. For
>> > the initial version, I will remove the flush (IRQ wrapper) and submit
>> > separate patch.
>>
>> The function is called with ap->lock held.  Nothing can happen
>> inbetween.
>
> Oh, or do you mean that upper layer may get data which hasn't finish
> transferring without the flush?
>

In the ISR, the AHCI library code reads the CI register and then
performs XOR to determine which commands are completed. Then it goes
and processes the completed command(s). I am worry that the process of
processing the completed command(s), the upper layer may act on the
data before the data arrived at the DDR/cache. In answering your
question, yes.

-Loc.
