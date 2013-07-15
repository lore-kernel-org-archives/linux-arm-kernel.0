From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon, 15 Jul 2013 16:53:46 +0200
Subject: [PATCH v5 1/7] sound: codec: wm8731: add rates constraints
In-Reply-To: <20130712114551.GD24508@sirena.org.uk>
References: <1373559359-31607-1-git-send-email-richard.genoud@gmail.com>
 <1373559359-31607-2-git-send-email-richard.genoud@gmail.com>
 <20130712114551.GD24508@sirena.org.uk>
Message-ID: <CACQ1gAhmp-i7vzPKuTMxqs9Ytjynz9NTvrQk9R08U9Fo-cVzMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/12 Mark Brown <broonie@kernel.org>:
> On Thu, Jul 11, 2013 at 06:15:53PM +0200, Richard Genoud wrote:
>
> Please always try to use commit logs that look like normal commit logs
> for the subsystem.
Ok, I'll pay attention to that.

>>       switch (freq) {
>> -     case 11289600:
>>       case 12000000:
>> +             wm8731->constraints = &wm8731_constraints_12000000;
>> +             break;
>>       case 12288000:
>> -     case 16934400:
>>       case 18432000:
>> -             wm8731->sysclk = freq;
>> +             wm8731->constraints = &wm8731_constraints_12288000_18432000;
>> +             break;
>> +     case 16934400:
>> +     case 11289600:
>> +             wm8731->constraints = &wm8731_constraints_11289600_16934400;
>>               break;
>>       default:
>>               return -EINVAL;
>>       }
>
> This isn't going to work with systems which have a variable clock as the
> input to the CODEC.  If it's imposing constraints the driver needs to
> allow setting the clock to zero as a way of removing constraints (and
> any existing drivers should be updated to do this if needed).
Maybe I'm wrong, but I didn't find any system using variable clock
with this codec.
The sam9g20ek (soc/atmel/sam9g20_wm8731.c) is not using a crystal, but
it's using a fixed clock anyway.
But there's soc/pxa/corgi.c and soc/pxa/poodle.c that puzzle me.
They seems to use a crystal, but they are setting a different sysclk
depending on the rate.
That seems wrong, but as I'm a newbie in ASoC...
