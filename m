From: javi.merino@arm.com (Javi Merino)
Date: Sun, 11 Dec 2011 15:09:41 +0000
Subject: [PATCH v2] ARM: pl330: Fix a race condition
In-Reply-To: <CABb+yY1rt5RDdb1pfs0v4qfvZ=gsXGYFVwEn6Ns1OA+0TZXSjg@mail.gmail.com>
References: <4E8C5425.80303@arm.com>	<1317892206-3600-1-git-send-email-javi.merino@arm.com>	<CAJuYYwTXf-XU0fdGT0+sggN-MEY3v7UHkfjNkM4+QUW464J9Ew@mail.gmail.com>	<4EB7B79A.2020004@arm.com>	<000c01ccada6$f83f5be0$e8be13a0$%kim@samsung.com>	<4ED3B89E.7070903@arm.com>	<000e01ccae48$d76a7ba0$863f72e0$%kim@samsung.com>	<4ED4AB9A.3060807@arm.com>	<CAJe_Zhem0yTOV4L-kJ91fQN++hFzCUgjOfxSnJR25PuYNTedVQ@mail.gmail.com>	<03f001ccb4b5$3441f5c0$9cc5e140$%kim@samsung.com>	<4EDF3989.3060108@arm.com>	<4EDFD278.9090101@arm.com>	<4EE1F7F0.70107@arm.com>	<CAJe_Zhcj_j+r+T5N_BdS-ENds1SmJs7-Pfyf8vrFkB75BGBaYg@mail.gmail.com>	<4EE20FF1.5070702@arm.com>	<CABb+yY0f8xxAj+rFeZ4e61Sfk0+0bMsAiZ-H5AeY4cfCd_VE5g@mail.gmail.com>	<4EE220A7.5070101@arm.com>	<CABb+yY2-1B65-UqRofj72zVuZUUk5c6pkqNGs15ZLnkrVheRDQ@mail.gmail.com>	<4EE26670.1060005@arm.com>
 <CABb+yY1rt5RDdb1pfs0v4qfvZ=gsXGYFVwEn6Ns1OA+0TZXSjg@mail.gmail.com>
Message-ID: <4EE4C7B5.2070803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/11 10:51, Jassi Brar wrote:
> On Sat, Dec 10, 2011 at 1:20 AM, Javi Merino <javi.merino@arm.com> wrote:
>>
>> What about properly tracking what we have sent to the DMA?  Something
>> like the following (warning *ugly* and untested code ahead, may eat your
>> kitten):
>>
> Yeah, this is like I said 'marker' method. Though we can clean it up a bit.
> 1) Pack req_running and lstenq together. Make lsteng return invalid value
> should there be no buff programmed, otherwise 0 or 1.

This can lead to starvation.  If lstenq is -1 when the DMA hasn't been
programmed yet, in _trigger() you don't know which buffer is the
"oldest", so you may end up always starting the new buffer and
forgetting about the other one.  lstenq as it is right now prevents that.

> 2) Try to merge req_running modification as part of MARK_FREE.

Yes, I thought about that, but I didn't want to code a proper solution
and then receive a "no, we shouldn't go down this road".

I'll clean it up and send a proper patch.

Cheers,
Javi

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
