From: rockford@yandex.ru (=?koi8-r?B?8MHOz9cg4c7E0sXK?=)
Date: Mon, 23 Mar 2015 11:22:13 +0300
Subject: Bug in drivers/net/ethernet/freescale/fec_main.c,
 TX is broken. In 4.0.0-rc3
In-Reply-To: <BLUPR03MB373FC71B9A8559E51084C26F50D0@BLUPR03MB373.namprd03.prod.outlook.com>
References: <390621425930628@web28o.yandex.ru>
 <3625951426018334@web26j.yandex.ru>
 <BLUPR03MB373A446E2D97992CA7AAA32F5020@BLUPR03MB373.namprd03.prod.outlook.com>
 <726281426513068@web10o.yandex.ru>
 <BLUPR03MB3739B9C6E14A106CCAEBA32F5020@BLUPR03MB373.namprd03.prod.outlook.com>
 <994171426532944@web7m.yandex.ru>
 <20150321205359.GM8656@n2100.arm.linux.org.uk>
 <CAOMZO5BnPQTFoBRr4EGH24_yZZAY6NJmVFg4WeiJcTqrYqki5A@mail.gmail.com>
 <BLUPR03MB373FC71B9A8559E51084C26F50D0@BLUPR03MB373.namprd03.prod.outlook.com>
Message-ID: <397281427098933@web12o.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



23.03.2015, 05:42, "fugang.duan at freescale.com" <fugang.duan@freescale.com>:
> From: Fabio Estevam <festevam@gmail.com> Sent: Sunday, March 22, 2015 6:36 AM
>> ?To: Russell King - ARM Linux
>> ?Cc: ????? ??????; Duan Fugang-B38611; netdev at vger.kernel.org; linux-arm-
>> ?kernel
>> ?Subject: Re: Bug in drivers/net/ethernet/freescale/fec_main.c, TX is
>> ?broken. In 4.0.0-rc3
>>
>> ?Hi Russell,
>>
>> ?On Sat, Mar 21, 2015 at 5:53 PM, Russell King - ARM Linux
>> ?<linux@arm.linux.org.uk> wrote:
>>> ?Given that this bug can seriously screw data up in undetectable ways
>>> ?(TCP checksums don't save you, because the FEC generates them on the
>>> ?data which it read from memory, even if it happened to read the data
>>> ?from the SoC's boot ROM) we do need to get this fixed ASAP.
>> ?Current mainline has 2b995f63987013 reverted, so 4.0-rc5 will not have
>> ?this corruption problem.
>>
>> ?Regards,
>>
>> ?Fabio Estevam
>
> We cannot revert the commit 2b995f63987013, otherwise there introduce other issue. The correct fix method is Russell King's fix in the previous mail.
> It is strange thing that I cannot reproduce the issue on i.MX6q sabresd board. Anyway, we must consider TSO case that it's not a fragmented skb.

It is just DMA_API_DEBUG=y error versus several data corruption error. DMA_API_DEBUG can be wrong too.
And did you do the check with that option enabled? This can cause delays in kernel enough to do actually write to the network before code in commit freed non-send data blocks.
I have it disabled all the time.

And you can check it by compiling a kernel over NFS, or big git merges over NFS, or doing big ftp transfer, etc.

--
 ??????
