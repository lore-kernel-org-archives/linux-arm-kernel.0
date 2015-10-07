From: stefan@agner.ch (Stefan Agner)
Date: Wed, 07 Oct 2015 16:34:30 -0700
Subject: [PATCH v12 2/5] mtd: nand: vf610_nfc: add hardware BCH-ECC support
In-Reply-To: <20150929205727.GP31505@google.com>
References: <1441242397-870-1-git-send-email-stefan@agner.ch>
 <1441242397-870-3-git-send-email-stefan@agner.ch>
 <20150929205727.GP31505@google.com>
Message-ID: <0291312bcff1d7a22f7cdee69848dfcb@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On 2015-09-29 13:57, Brian Norris wrote:
> Pushed this patch to l2-mtd.git, as it looks pretty much good. Although,
> I'd like raw read support...
> 
> On Wed, Sep 02, 2015 at 06:06:34PM -0700, Stefan Agner wrote:
>> This adds hardware ECC support using the BCH encoder in the NFC IP.
>> The ECC encoder supports up to 32-bit correction by using 60 error
>> correction bytes. There is no sub-page ECC step, ECC is calculated
>> always accross the whole page (up to 2k pages).
>>
>> Limitations:
>> - HW ECC: Only 2K page with 64+ OOB.
>> - HW ECC: Only 24 and 32-bit error correction implemented.
>>
>> Raw writes have been tested using the generic nand_write_page_raw
>> implementation. However, raw reads are currently not possible
>> because the controller need to know whether we are going to use
>> the ECC mode already at NAND_CMD_READ0 command time. At this point
>> we do not have the information whether it is a raw read or a
>> regular read at driver level...
> 
> Hmm, can you get this in ecc.read_page_raw()?

Even just a read_page_raw implementation doesn't help. The controller
requires the ECC to be configured at command issue time, and the driver
issues the command in the cmdfunc callback. The function
nand_do_read_ops calls cmdfunc before ecc.read_page_raw...

I could just bail out in the NAND_CMD_READ0 case, and execute the
command from within the ecc.read_page_raw callback function. A bit
hacky, but that would work.

For that case, it would be nicer if cmdfunc somehow provides the
information that a raw read is requested, we would have that information
in nand_do_read_ops. However, that would need an extension of the
cmdfunc interface... Also, not sure how that should look like.

--
Stefan
