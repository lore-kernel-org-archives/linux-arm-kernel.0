From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Wed, 22 Oct 2014 19:24:49 -0300
Subject: [RESEND/PATCH] i2c: pxa: Use suspend() and resume() instead of
 the _noirq hooks
In-Reply-To: <7hzjcqe9ge.fsf@deeprootsystems.com>
References: <1413829432-7815-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <7hzjcqe9ge.fsf@deeprootsystems.com>
Message-ID: <54482EB1.9030407@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/20/2014 06:07 PM, Kevin Hilman wrote:
> Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> writes:
> 
>> The _noirq were previously chosen to make sure all the users of the
>> adapter were suspended by the time the adapter itself enters the
>> suspended state.
>>
>> The {suspend,resume}_noirq usage was converted from an earlier
>> implementation based on suspend_late and resume_early on this commit:
>>
>> commit 57f4d4f1b72983f8c76e2f232e064730aeffe599
>> Author: Magnus Damm <damm@igel.co.jp>
>> Date:   Wed Jul 8 13:22:39 2009 +0200
>>
>>     I2C: Rework i2c-pxa suspend_late()/resume_early()
>>
>> However, all the I2C devices are probed as children of its I2C adapter,
>> and hence the device model guarantees they are suspended before its parent, and
>> resumed after it.
>>
>> In other words, there's no need to use the _noirq hooks to get a suspend/resume
>> device/adapter order.
> 
> Are you sure *really* about this?
> 

Hm, now you made me doubt.

> It's usally not the children that are the problem here.  It's usually
> some other driver trying to use an I2C device e.g. MMC changing voltage
> using an I2C-based PMIC during its suspend process.
> 

So we can't know for sure if using suspend/resume is going to work OK for
a I2C adapter?

There might be some use of it that can't be accurately modeled in the
device model.

I.e., the above example is a dependency of MMC on the I2C being suspended
after him, but right now there's no way to model such relationship.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141022/21305485/attachment.sig>
