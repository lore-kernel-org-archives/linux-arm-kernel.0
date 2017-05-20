From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 20 May 2017 15:50:33 +0200
Subject: [PATCH v2 00/18] ARM64: meson: DT cleanups
In-Reply-To: <CAFBinCA18Y0CXvu4DtDnz=zvYxpqUNA5WRK5teO_T8zTVj4FnQ@mail.gmail.com>
References: <20170513143337.14278-1-afaerber@suse.de>
 <36c02d8a-d3e2-4330-f600-e49a1ba680e8@baylibre.com>
 <5fb0130c-473e-dc15-b60c-e5b6144031ad@suse.de>
 <CAFBinCA18Y0CXvu4DtDnz=zvYxpqUNA5WRK5teO_T8zTVj4FnQ@mail.gmail.com>
Message-ID: <bbff04ce-2d19-3b98-1c64-5aa81c1de692@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.05.2017 um 22:24 schrieb Martin Blumenstingl:
> On Mon, May 15, 2017 at 9:10 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> Hi Neil,
>>
>> Am 15.05.2017 um 10:16 schrieb Neil Armstrong:
>>> Hi Andreas,
>>>
>>> On 05/13/2017 04:33 PM, Andreas F?rber wrote:
>>>> Hello Kevin,
>>>>
>>>> This series fixes several cosmetic issues, on top of your for-next branch.
>>>>
>>>> Patches 3-6 rename a node, the rest should all be non-functional changes.
>>>
>>> These are OK.
>>>
>>>> PLEASE STOP merging random new nodes at the bottom of DT files!
>>>> Just like it's a convention to sort new nodes by unit address, it has been
>>>> a convention to sort by-label nodes by their label. As discussed here and
>>>> elsewhere, this helps avoid merge conflicts and makes nodes easy to find.
>>>> I don't care whether we order A0 before A or after, but adding new HDMI
>>>> or CVBS nodes at the very bottom is totally out of alphabetical order.
>>>> Since my v1 you really should've known that...
>>>
>>> It's not perfect, but now it's done, live with it, this has already been discussed.
>>
>> No.
>>
>> Copy&pasting your comment N times does not make it any more valid. My
>> files, my rules - I insist on vega-s95, gxbb and gx, which you guys
>> refactored out from my gxbb, to be tidy.
>>
>>> Please try to refactor boards DTS with their parent reference design instead
>>> like it was done with the P212 and what I did with the Wetek Hub and Play2.
>>
>> Negative, that means any additions and changes for the reference boards
>> will slip through into boards that you do not test.
>>
>> We've already seen how "well" that works with R-Box Pro having inherited
>> a broken U-Boot network configuration due to internal vs. external PHY.
> could you please share your vision how we can a) keep the amount of
> duplicate .dts code low while b) avoiding "accidental" changes? maybe
> there's a better way (compared to what we have now) which I've not
> thought of yet

The reason for aligning all exynos5250 .dts files was to be able to use
diff -u to compare files for differences. Obviously the board compatible
will always show up, but by ordering alphabetically and by inheriting
some common order for the other nodes without particular convention only
the actual changes show up. That's why I had started the voluntary work
of also cleaning up boards that I do not have access to. You had already
adopted alphabetical order for Vim, thanks for that.

Basically we have two different concepts here:
One is physical reuse, e.g., the boards all use the same S905 chip from
Amlogic, so we can safely inherit meson-gxbb.dtsi.
The other is design reuse. Rather than reusing the same physical board,
they are different boards based on a common template but they may
contain variations. Thus there is no guarantee that everything in the
original template is in each derived board. The difficulty for us here
is that for most TV boxes no schematics are available to decide whether
there are any differences compared to Amlogic's P/Q reference boards. So
we would only find out when something breaks.

For example, continuing my work on the NanoPi K2 I have found several
minor variations of how power supplies are called and which GPIO is
being used, compared to Odroid-C2 or Vega.

Therefore the usual solution is that contributors of individual board
trees also need to maintain them long-term, as opposed to expecting
BayLibre to do that and magically getting everything for free.
Specifically, I added the vega-s95 and am adding the nanopi-k2, so once
you add serdev and Bluetooth nodes for your Vim, we will have to
manually adopt those for other boards. If we don't notice or don't do
our additions, the boards will continue to boot as before but just not
get any new cool features. On the other hand, if some driver change gets
performed, all in-tree files need to be updated, which provides some
more motivation for vendors and users to participate in mainline
development.

>>>> Similarly, Khadas Vim shouldn't have been merged with the "bcrmf" typo.
>>>
>>> Well, this is why we have 7 rc releases after the merge window...
>>
>> If Kevin is the maintainer, then he needs to carefully review patches.
>> It is not my job to review all patches when BayLibre gets paid for it!
> please stop these accusations,

Being the Amlogic maintainer is not an "accusation".

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts?id=e15d2774b8c096f116bf7192b37e8652da71369e

carries his Signed-off-by, that's for a fact.

Also FTR I found it a really weird assumption that ugly naming should be
noticed during RC testing. Therefore my point that this is about review,
not testing.

Fact is also that BayLibre people appear to be working on Amlogic stuff
during the week and with few exceptions unlike you and me are rather
silent the weekend, which is when I get to look into these platforms. So
whatever their formula of payment may be (I don't care), they seem to
have more time to spend on this as part of their job. Me, I am not a
kernel developer in my day job. So telling a hobbyist contributor to do
their job is really off.

> I have just sent a fix which should
> actually allow Kevin (and anybody else) to properly review the
> Broadcom FullMAC wireless SDIO devices in the future: [0]

Thanks for catching that. Note that you may have some more letter twists
in your cover letter.

Regards,
Andreas

> [0] https://marc.info/?l=linux-wireless&m=149487928516583&w=2

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
