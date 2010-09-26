From: adrian.wenl@gmail.com (Lei Wen)
Date: Sun, 26 Sep 2010 22:32:47 +0800
Subject: pxa3xx_nand issues
In-Reply-To: <201009231729.48147.pieterg@gmx.com>
References: <201009221912.24905.pieterg@gmx.com>
	<AANLkTikdru5gH=ySKw13CzrDwbhNCArgQqjcE2cydB4L@mail.gmail.com>
	<201009231332.26566.pieterg@gmx.com>
	<201009231729.48147.pieterg@gmx.com>
Message-ID: <AANLkTik47Q48EbjFz9eak0vF1AstWv_sgB+BPQtDWEVF@mail.gmail.com>
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

PXA3xx NAND controller write semantic is to send whole page of data to
the NAND flash with
the page's address. If you set the ndcr1 not page align value, it is
also fine by pxa3xx_nand
sending the data to the flash, but nand flash would not accept this
kind of behavior as
it is defined in its spec.

Certainly, if you really need to do this, there is still has ways. :)
Send the RANDOM DATA INPUT command (0x80 + 5cycle address + 0x85 +
2cycles column address) + 0x10 would serve this.
But seems the pxa310 cannot do such job, which is supported by newer
silicon in pxa168 or mmp2.

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

You may notice that when a new file system is mounted, the flash is
only read by controller.
This mean your uboot is all right for writing, and your kernel is also
ok for reading.
While your driver write function may got broken. Timing? Not so sure...

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

Em, Although ERR_SBERR indicate this error can be corrected by nand
controller, it
still make sense to report this to upper level. FS like UBIFS could
use this message to
do the flash data integrity maintenance. This already be fixed in my
patch set which
sent a month ago.
>
> That's what I did in the remainder of my tests (after having unmarked the
> blocks that were wrongly marked bad) so I think this issue did not
> contribute to my biterror problems.

Biterr may be caused by timing, bad block... I think you'd better use
the mtd test built in linux
kernel to make sure timing is all right.

Best regards,
Lei
