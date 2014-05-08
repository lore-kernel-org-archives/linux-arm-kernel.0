From: ezequiel@vanguardiasur.com.ar (=?UTF-8?Q?Ezequiel_Garc=C3=ADa?=)
Date: Thu, 8 May 2014 14:00:36 -0300
Subject: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
In-Reply-To: <535F5BA5.6000903@ti.com>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <CAGm1_kvHtSLNEfkJ24xZGGzsqAjHDTM1XztnX-QGs4iM5voMUw@mail.gmail.com>
 <535F5BA5.6000903@ti.com>
Message-ID: <CAAEAJfCG3c++WBgeipF6sCE1-9pHgU80t2Mpz0Y4koU5-uEwSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi George,

On 29 April 2014 04:58, George Cherian <george.cherian@ti.com> wrote:
> On 4/29/2014 11:49 AM, Yegor Yefremov wrote:
>>
>> On Thu, Apr 24, 2014 at 11:11 PM, Ezequiel Garcia
>> <ezequiel@vanguardiasur.com.ar> wrote:
>>>
>>> The DMA controller is needed for the USB controller to be correctly
>>> registered. Therefore, if the DMA node is located at the end an
>>> unecessary
>>> probe deferral is produced systematically.
>>>
>>> This is easily fixed by moving the node at the beggining of the child
>>> list,
>>> so it's probed first.
>
> This will give issues on module removal.
> Since we use device_for_each_child in remove patch, it will try to remove
> cppi dma controller, while the channel
> is still in use by musb node.
>

OK, this seems confusing: are you sure module removal works?

Doing this simple test on v3.15-rcN:

$ modprobe musb_dsps
$ modprobe musb_am335x
$ modprobe musb_am335x -r

And the kernel blows up :-(

I've been debugging this and I think we simply cannot support removal
of the musb_am335x
module.

Had this ever worked before?
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
