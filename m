From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 25 Sep 2010 10:50:04 +0800
Subject: pxa3xx_nand issues
In-Reply-To: <201009231729.48147.pieterg@gmx.com>
References: <201009221912.24905.pieterg@gmx.com>
	<AANLkTikdru5gH=ySKw13CzrDwbhNCArgQqjcE2cydB4L@mail.gmail.com>
	<201009231332.26566.pieterg@gmx.com>
	<201009231729.48147.pieterg@gmx.com>
Message-ID: <AANLkTik8N+ATdhygBsatnrYJ0MOLd+L5ujB47Xrf_O_D@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 11:29 PM, pieterg <pieterg@gmx.com> wrote:
> On Thursday 23 September 2010 13:32:26 pieterg wrote:
>> On Thursday 23 September 2010 08:05:56 Eric Miao wrote:
>> > On Thu, Sep 23, 2010 at 1:12 AM, pieterg <pieterg@gmx.com> wrote:
>> > > In my search for the cause of the huge number of single/double bit
>> > > errors I'm experiencing on colibri pxa320/310 devices, I've come
>> > > across this commit
>> > >
> http://git.kernel.org/?p=linux/kernel/git/ycmiao/pxa-linux-2.6.git;a=commit;h=7f9938d0fd6c778bd0ce296a3e3b50266de2b892
>> > > According to the commitlog, it attempts to work around an issue
>> > > regarding non-page-aligned reads.
>> > > The workaround seems to force page-aligned access, by dropping the
>> > > offset within the page (column address bytes).
>> > > However, in my setup (with a jffs2 filesystem on nand),
>> > > non-page-aligned reads never occur, but non-page-aligned writes occur
>> > > very frequently. (during the jffs2 gc).
>> > > These are also affected by this commit, while the commitlog does not
>> > > state whether or not the same issue would occur for the program
>> > > command, and in that case, whether or not the same workaround would
>> > > apply.
>> > >
>> > > I've tried to revert the commit, but unfortunately this doesn't
>> > > reduce the huge number of single/double bit errors (and jffs2 crc
>> > > errors as a result) I'm getting.
>> > >
>> > > But having these non-aligned writes during GC, would that indicate a
>> > > problem with my jffs2 image parameters perhaps?
>> > > (though I cannot imagine this could actually cause double bit errors)
>> >
>> > It might not be related to the commit above. ?The NAND controller will
>> > always read the whole page and ignoring the column address, that patch
>> > tries to make less confusion. The offset is actually handled completely
>> > by software (memorized).
>>
>> I can see how the read offset works, but I do not quite see how this
>> would work for writes (which call the same prepare_read_prog_cmd, and
>> have their column address stripped as well).
>> Found out that this happens when writing oob data by the way; these are
>> writes with offset 2048 within the page. Jffs2 does this when writing
>> cleanmarkers.
>
> Tested this, and found out that this commit is actually quite essential for
> writes as well.
> Without it, the OOB data doesn't get written.
> So we can close this part of the topic, commit 7f9938d0 is perfectly fine.
>
>> I could identify about 10 eraseblocks with pages which produce
>> single/double bit errors.
>> After I marked them bad (manually), I've seen no more bit errors, and the
>> jffs2 rootfs has remained perfectly healthy.
>
> Turned out to be a short-term solution.
> After a while I got more double-bit errors, and ended up bad-marking a dozen
> or so other eraseblocks, and it does not seem to stop.
>
> Strangest thing is that when I write a new jffs2 image with uboot (nand
> erase, nand write) or with the kernel (flash_eraseall, nandwrite), it never
> contains any biterrors when I mount it.
> Only after the filesystem has been mounted, gets modified, and then after
> the first reboot, the biterrors are there.
Could you make sure whether these "wrong" block are truely bad block?
Maybe you can erase/write them continuously multi-times in XDB.

>
> One other issue which I noticed because besides double bit errors I get many
> single bit errors as well; the ERR_SBERR is never cleared.
> ERR_DBERR is cleared to ERR_NONE in two locations, but ERR_SBERR is not.
> (probably in order to allow pxa3xx_nand_ecc_correct to pick it up)
> However, I've seen that the retcode could still be ERR_SBERR in
> pxa3xx_nand_waitfunc, causing an erase error to be assumed, as a result all
> eraseblocks in the partition ended up being marked bad in a loop, till
> there were no more remaining eraseblocks.
> I guess ERR_SBERR should probably be ignored in pxa3xx_nand_waitfunc?
>
Yes, ERR_SBERR should be ignored since NAND controller can correct this.

> That's what I did in the remainder of my tests (after having unmarked the
> blocks that were wrongly marked bad) so I think this issue did not
> contribute to my biterror problems.
>
> Rgds, Pieter
>
