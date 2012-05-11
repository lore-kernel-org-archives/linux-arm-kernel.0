From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Sat, 12 May 2012 02:36:32 +0530
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FAD6848.40700@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FA3F308.6030900@ti.com>
 <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
 <201205041923.07620.arnd@arndb.de>
 <CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com>
 <4FA7F009.5010003@wwwdotorg.org>
 <CAJe_ZheHFP9NZEiZfCvS3LL1k7xamzGq4Oep8gfmPRi6RR7R5Q@mail.gmail.com>
 <4FA94B49.5050500@wwwdotorg.org>
 <CAJe_Zhf0=Qnsgsc7U_GbKxc0_6DKj33QWs0UW2giyrVEjPnrvw@mail.gmail.com>
 <4FAAC111.9020308@wwwdotorg.org>
 <CAJe_Zhcrr2QqoY=H3=3EJLPQBjC3Yc43EDjqYXaNok9-T+=0yw@mail.gmail.com>
 <4FABF445.3030105@wwwdotorg.org>
 <CAJe_ZhduQuHnFyF20VnjZW9uz1szwL6O7=ow+tMqanmeHs58pQ@mail.gmail.com>
 <4FAD6848.40700@wwwdotorg.org>
Message-ID: <CAJe_Zhc8T-vR8fjFLyT4bz6dj=TUyx0F8k=fAPYn_MnbGW5LBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2012 00:58, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/10/2012 01:59 PM, Jassi Brar wrote:
>
>> I think arbitrary numerical tokens are a reasonable price to pay for the
>> robustness and simplicity they bring.
>
> I have to disagree here.
>
> Using phandle+ID is almost as simple, and much more flexible. Global IDs
> have a number of disadvantages:
>
> a) You have to somehow keep them unique. Even with just a single .dts
> file, that's going to be a little painful since there's no central table
> of these IDs.
>
> What if the DT is composed of a bunch of chunks that represent pluggable
> boards, which may be mixed/matched together depending on what the user
> actually plugged in? Then, you have to be very careful to keep the n
> different files' numbering ranges segregated, or conflicts will occur.
>
You might want to revisit this point after working out the finer details of what
you propose for a client's specifier :)

>>
>> Well, I doubt if there would ever be enough such platforms to warrant a
>> new generic framework. For now, I would leave that to be a matter between
>> the dmac driver and its DT node.
>>
>> Similarly let every dmac, being unique, require DT data in it's own custom
>> format - I don't believe we can find a generic DT format for every kind of
>> dmac that does exist or would exist. (For ex, you found a way for RMK's
>> mux'ed req_lines, but what about assigning priorities to clients which is
>> possible with PL08X dmacs but not most others?)
>
> Good question. Again thought that sounds a little like policy, so
> perhaps should be negotiated at runtime rather than described in DT?
>
As much as we love everything to be runtime configurable, I am afraid it
can't be. We can't add new calls to the dmaengine api for simply
supporting specific features of various dmacs (priority in this case)
Because that would mean ideally every client going through the mostly
useless ritual of querying/setting those features and most dmacs
just 'pretending' to support some, except for the rare ones that actually do.
So as much as these sound like policy, they would usually be directly
hardcoded via dt for the machine or deducted by the dmac driver.

>>
>>> client0: i2s {
>>> ? /* has 2 DMA request output signals: 0, 1 */
>>> };
>>>
>>> client1: spdif {
>>> ? /* has 2 DMA request signals: 0, 1 */
>>> };
>>>
>> Do we also need to somehow tag these signals for the client to
>> differentiate between TX and RX channel ?
>
> Yes, the client's DT binding would certainly need to describe how many
> DMA request signals its HW generates, and give a unique ID to each. The
> driver would need to request a DMA channel for a specific one of its DMA
> requests.
>
Did I read "give a unique ID to each" correctly ?
Could you please take some time out to jot down an example of how a
typical client's dma specifier should look.

FWIW, I think I can live with what you propose. Let us go for the kill.

Thanks.
