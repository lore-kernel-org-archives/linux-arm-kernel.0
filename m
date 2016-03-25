From: lakshmi.sai.krishna.potthuri@xilinx.com (Lakshmi Sai Krishna Potthuri)
Date: Fri, 25 Mar 2016 13:41:16 +0000
Subject: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
 structure.
In-Reply-To: <20160322100615.GA2566@sirena.org.uk>
References: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
 <20160321130734.GS2566@sirena.org.uk>
 <4FF8F58FAA9D5D4193D4E554E4352C5902C6D34C@XAP-PVEXMBX02.xlnx.xilinx.com>
 <20160322100615.GA2566@sirena.org.uk>
Message-ID: <4FF8F58FAA9D5D4193D4E554E4352C5902C6DB59@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

>-----Original Message-----
>From: Mark Brown [mailto:broonie at kernel.org]
>Sent: Tuesday, March 22, 2016 3:36 PM
>To: Lakshmi Sai Krishna Potthuri
>Cc: Michal Simek; Soren Brinkmann; David Woodhouse; Brian Norris; Javier
>Martinez Canillas; Boris Brezillon; Stephen Warren; Geert Uytterhoeven;
>Andrew F. Davis; Marek Vasut; Jagan Teki; Rafa? Mi?ecki; linux-
>mtd at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
>spi at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Harini Katakam;
>Punnaiah Choudary Kalluri; Anirudha Sarangi
>Subject: Re: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
>structure.
>
>On Tue, Mar 22, 2016 at 06:39:51AM +0000, Lakshmi Sai Krishna Potthuri
>wrote:
>
>Please fix your mail client to word wrap within paragraphs at something
>substantially less than 80 columns.  Doing this makes your messages much
>easier to read and reply to.  Please also avoid reflowing other text into longer
>lengths, this makes things worse.
>
>> >This isn't enough to add the feature - a client driver trying to make
>> >use of this needs to be able to tell if the cycles are actually going
>> >to be inserted.  I'd expect to see a capability flag that can be
>> >checked and some error checking so that if we try to do a transfer
>> >with dummy cycles and can't support it we don't silently ignore the
>> >dummy cycles, ideally also something that'll handle multiples of 8
>> >bits with SPI controllers that don't otherwise support this feature.
>
>> Currently, all fast reads use 8 cycles or 1 byte of dummy. This generally
>works.
>> But it can be vary based on the flash and the type of read command.
>> Dummy bytes are taken care of in m25p80.c by adjusting the len field:
>> Length = size of (command + address + dummy byte)
>
>> There might be controllers (like ZynqMP GQSPI) that would be able to
>> use the information that dummy byte(s) were added and the precise
>> number of dummy cycles. This patch does not disturb the existing
>> implementation of adjusting length (as described above). It adds an
>additional optional feature.
>> So there is no harm to controllers that can't support it - they can
>> ignore it and still work with the existing "length adjustment"
>implementation.
>> If you think there value in adding a capability flag, please let me know.
>
>This is really not what I'd expect to happen, I'd expect that these dummy
>cycles would be in addition to the actual data (see my request for better
>documentation...).  If they overlap with the data then what is the point in
>specifying this?  It's more work for the host, what benefit do we get from
>doing it over just handing it like a normal byte?

len field in the transfer structure contains dummy bytes along with actual data
bytes, controllers which requires dummy bytes use len field and simply Ignore
the dummy field (contains only no of cycles)added in this patch. Controllers
(like ZynqMP GQSPI) expects dummy in cycles won't work directly by using
len field because host driver doesn't know that len field of a particular transfer
includes dummy bytes or not (and also number of dummy bytes included in len
field). In such cases driver use this dummy field to identify the number of dummy
cycles and based on that it will send the required number of dummy cycles (which
i did in the second patch).

Regards
Sai Krishna


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
