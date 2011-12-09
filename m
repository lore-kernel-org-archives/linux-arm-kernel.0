From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 9 Dec 2011 22:20:48 +0530
Subject: [PATCH v2] ARM: pl330: Fix a race condition
In-Reply-To: <4EE220A7.5070101@arm.com>
References: <4E8C5425.80303@arm.com>
 <1317892206-3600-1-git-send-email-javi.merino@arm.com>
 <CAJuYYwTXf-XU0fdGT0+sggN-MEY3v7UHkfjNkM4+QUW464J9Ew@mail.gmail.com>
 <4EB7B79A.2020004@arm.com>
 <000c01ccada6$f83f5be0$e8be13a0$%kim@samsung.com>
 <4ED3B89E.7070903@arm.com>
 <000e01ccae48$d76a7ba0$863f72e0$%kim@samsung.com>
 <4ED4AB9A.3060807@arm.com>
 <CAJe_Zhem0yTOV4L-kJ91fQN++hFzCUgjOfxSnJR25PuYNTedVQ@mail.gmail.com>
 <03f001ccb4b5$3441f5c0$9cc5e140$%kim@samsung.com>
 <4EDF3989.3060108@arm.com> <4EDFD278.9090101@arm.com>
 <4EE1F7F0.70107@arm.com>
 <CAJe_Zhcj_j+r+T5N_BdS-ENds1SmJs7-Pfyf8vrFkB75BGBaYg@mail.gmail.com>
 <4EE20FF1.5070702@arm.com>
 <CABb+yY0f8xxAj+rFeZ4e61Sfk0+0bMsAiZ-H5AeY4cfCd_VE5g@mail.gmail.com>
 <4EE220A7.5070101@arm.com>
Message-ID: <CABb+yY2-1B65-UqRofj72zVuZUUk5c6pkqNGs15ZLnkrVheRDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2011 at 8:22 PM, Javi Merino <javi.merino@arm.com> wrote:
>
> I think the best solution would be to revert
> ee3f615819404a9438b2dd01b7a39f276d2737f2 and go back to my original
> patch (in the beginning of this thread):
>
> http://article.gmane.org/gmane.linux.ports.arm.kernel/133110
>
> What do you think?

Well, we have to resort to that if we can't find something simpler.

What do you think about ...

diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
index f407a6b..3a51cdd 100644
--- a/arch/arm/common/pl330.c
+++ b/arch/arm/common/pl330.c
@@ -1546,7 +1546,7 @@ int pl330_chan_ctrl(void *ch_id, enum pl330_chan_op op)

 		/* Start the next */
 	case PL330_OP_START:
-		if (!_thrd_active(thrd) && !_start(thrd))
+		if (_state(thrd) == PL330_STATE_STOPPED && !_start(thrd))
 			ret = -EIO;
 		break;

Thanks
-jassi

[Sorry I don't have any pl330 platform handy]
