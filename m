From: kevin@bracey.fi (Kevin Bracey)
Date: Thu, 05 Dec 2013 18:49:56 +0200
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized using
 pinfunc.
In-Reply-To: <1502243.eRBlCfUhTO@amdc1227>
References: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
 <CACRpkdYrPd9tnO48bA_5n+-k=KEDyhY7czkCNhTZfpgF3ar+LQ@mail.gmail.com>
 <20131205150747.GW29268@sirena.org.uk> <1502243.eRBlCfUhTO@amdc1227>
Message-ID: <52A0AEB4.7090909@bracey.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2013 17:11, Tomasz Figa wrote:
> On Thursday 05 of December 2013 15:07:47 Mark Brown wrote:
>> On Tue, Dec 03, 2013 at 10:29:42AM +0100, Linus Walleij wrote:
>>
>>> So a suggested patch to support weak hogs would be interesting
>>> to look at. Can you provide details on how you think this would
>>> work?
>> Or should we be going and applying the default state to all devices on
>> init without worrying about a driver appearing?
> If a device isn't used, then it's often better to configure the pins for
> a different function, such as GPIO, to minimize leakage current.
>

And there can also be mutually-exclusive drivers choosing different 
default states for the same pin. I think you do need a separate "safe" 
indicator.

My current thought is that  a late-init "make safe all unclaimed pins" 
pass would make sense - you can't really mess with pins in an automated 
fashion on init, as it can mess up bootloader->driver handover.   There 
already exist late-init "turn off all unclaimed clocks" (at least on 
shmobile) and "turn off all unclaimed regulators", and it would fit that 
model.

Kevin
