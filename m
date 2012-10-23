From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Oct 2012 10:58:03 +0200
Subject: [PATCH v2] pinctrl: reserve pins when states are activated
In-Reply-To: <20121022190743.GE4730@atomide.com>
References: <1350651909-5337-1-git-send-email-linus.walleij@stericsson.com>
 <20121019181019.GP4730@atomide.com>
 <CACRpkdZazjMoSzkr5t15-GeCnQKCJDsZyvT=KVMyw5XhjDybGQ@mail.gmail.com>
 <20121022190743.GE4730@atomide.com>
Message-ID: <CACRpkdYYp+2ZVUd+wxYwDdBC+Bxiv2_N-1JRrbXSjV3WxuF8+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 9:07 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Linus Walleij <linus.walleij@linaro.org> [121022 01:22]:

>> If this turns out to be a severe performance bottleneck, I
>> suggest to add some additional constraint API, like
>> pinctrl_set_pinmux_homegeneous_pinsets(true) that will
>> at runtime select whether the pin allocation is done when
>> getting the pinctrl handle instead.
>
> Or maybe you could release + reserve the pins only if the
> pins change?

Umm... not quite following but show me the code :-D

In the code as it stands currently we only detect
if a state changes and then it assumes the old state need
to be deactivated before activating a new one.

I think that in order to do that for a state A->B transition
we need to:

1. Get the pins for mux setting A
2. Get the pins for mux setting B
3. Loop over the pin array and compare
4. If all are the same, goto 7
5. Release pins for setting A
6. Acquire pins for setting B
7. Update all pin descs to point to setting B
8. Done

Hm, I can see a patch like that...

Yours,
Linus Walleij
