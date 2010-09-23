From: mattjreimer@gmail.com (Matt Reimer)
Date: Thu, 23 Sep 2010 11:03:17 -0700
Subject: pxa3xx_nand issues
In-Reply-To: <201009231729.48147.pieterg@gmx.com>
References: <201009221912.24905.pieterg@gmx.com>
	<AANLkTikdru5gH=ySKw13CzrDwbhNCArgQqjcE2cydB4L@mail.gmail.com>
	<201009231332.26566.pieterg@gmx.com>
	<201009231729.48147.pieterg@gmx.com>
Message-ID: <AANLkTikXvuzVuNuZ_t0Sk6Br9FsfDp=HaJu0Q4WS1iLu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 8:29 AM, pieterg <pieterg@gmx.com> wrote:
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

IIRC I came up with this patch while trying to use JFFS2 on a pxa320.

Matt
