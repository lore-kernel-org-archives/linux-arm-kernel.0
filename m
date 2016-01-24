From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 24 Jan 2016 12:29:16 +0100
Subject: [PATCH V7 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs
 without a stop bit
In-Reply-To: <1453197766-18976-4-git-send-email-sricharan@codeaurora.org>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-4-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160124112915.GA1775@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> "If this is the last message in a group, it is followed by a STOP.
> Otherwise it is followed by the next @i2c_msg transaction segment,
> beginning with a (repeated) START"

This is correct.

> So the expectation is that there is no 'STOP' bit inbetween individual
> i2c_msg segments with repeated 'START'. The QUP i2c hardware has no way
> to inform that there should not be a 'STOP' at the end of transaction.
> The only way to implement this is to coalesce all the i2c_msg in i2c_msgs
> in to one transaction and transfer them. Adding the support for the same.

So, there will not be a REP_START condition on the bus? I am sorry to
say that I can't accept this. A REP_START is a REP_START and nothing
else. There are devices which will get confused if there is no real
REP_START condition.

Without knowing the HW in detail, can't you implement I2C_M_NOSTART and
let the touchscreen driver use it via regmap? That would be the proper
way (from what I understand).

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160124/7cc28096/attachment.sig>
