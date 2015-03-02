From: stefan@agner.ch (Stefan Agner)
Date: Mon, 02 Mar 2015 22:44:50 +0100
Subject: [RFC 2/5] =?UTF-8?Q?mtd=3Afsl=5Fnfc=3A=20Add=20hardware=20=34?=
 =?UTF-8?Q?=35=20byte=20BHC-ECC=20support=20for=20=32=34=20bit=20correctio?=
 =?UTF-8?Q?ns=2E?=
In-Reply-To: <54F4D8A5.7020500@tastycactus.com>
References: <87siupheou.fsf@nbsps.com>
 <1389222441-4322-1-git-send-email-bpringlemeir@nbsps.com>
 <1389222441-4322-3-git-send-email-bpringlemeir@nbsps.com>
 <127db6b73356442d2ba12e8c011038cc@agner.ch> <87r3zaxgtr.fsf@nbsps.com>
 <c444059de888a661fadf3d6be598a98d@agner.ch> <87lhphyjkg.fsf@nbsps.com>
 <0bc8cec13bcf5b9cbea9cd3345815e4a@agner.ch> <8761dit9u9.fsf@nbsps.com>
 <f3bc6eda0c826601e136f3dad91d9674@agner.ch> <87k2yzqw1r.fsf@nbsps.com>
 <54F4D8A5.7020500@tastycactus.com>
Message-ID: <274cb58b660f6802cb5872dee7f5ff47@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-02 22:39, Aaron Brice wrote:
> On 03/02/2015 08:05 AM, Bill Pringlemeir wrote:
>> On 28 Feb 2015, stefan at agner.ch wrote:
>>
>>> The flash chip mentioned above requires 8-bit error correction per 512
>>> byte block, hence I increased the ECC to the maximum available level
>>> (60-byte ECC, see page below). One thing which is not very nice, in
>>> order to fit the 60-byte ECC into the 64-byte OOB, I had to shorten
>>> the BBT pattern and set it at the very beginning of the page. This
>>> works fine, however this basically sets the page also to factory bad,
>>> I'm not sure if this is ok? Otherwise, we also could use a BBT pattern
>>> of length 1 (used by cafe_nand.c too).
>> I guess that is a DT option?  I wouldn't be an expert on this.  So
>> submitting it to the linux-mtd is good.
>>
>> I am also not sure if the HW ECC will work with 'sub-pages'.  I think a
>> college of your at Toradex submitted a patch to the u-boot.  I am pretty
>> sure that it could work with software ECC, but maybe disabling it is
>> easiest.
>>
>>> What do you think? I would like to respin the NFC patch, with my
>>> U-Boot changes and this change included...
>> Please go ahead.  Markus M <marb@ixxat.de> is also using the fsl_nfc
>> driver on a Freescale MPC5125 board, so it is probably good to copy your
>> patches to him.  At least, he can test on a BE platform.
>>
>> People also complained about JFFS and this version of the driver.  I
>> didn't investigate that.
> 
> I also noticed a problem with JFFS2 and the driver, where fs changes
> were lost after reboot.  Didn't investigate, switched to UBIFS..

Did you happen to use HW ECC? The controller seems to use byte 19
onwards to store the ECC bytes, where also JFFS2 stores it's meta data
when using a NAND chip with 64-byte OOB (see
http://www.linux-mtd.infradead.org/doc/nand.html). However, I think
UBI/UBIFS is a good choice anyway.

--
Stefan
