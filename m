From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 14 Nov 2014 09:11:15 +0200
Subject: [PATCHv6 4/5] hwspinlock/core: add common OF helpers
In-Reply-To: <54651C48.90809@ti.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com>
 <1410553499-55951-5-git-send-email-s-anna@ti.com>
 <CAK=WgbamdqAufjC4Xb5moERRBSB-cO6c1RPTE=f+dp75F+Eh7A@mail.gmail.com>
 <5463B5B6.8040709@ti.com>
 <CAK=WgbbatPTiz3efDWHVEcuug_UQfkCViMoK0zcfUg3JwB2oTA@mail.gmail.com>
 <5464EC7A.7050603@ti.com>
 <CAK=WgbbodS8GsUxQbkyCp6hAG+Ko4LMirx+pUa8_fUdxWFasvw@mail.gmail.com>
 <54651C48.90809@ti.com>
Message-ID: <CAK=WgbYMM19-rWLOBjix+TA3fF_Pb25ia1rutDxYSUg9SV0efg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Thu, Nov 13, 2014 at 11:02 PM, Suman Anna <s-anna@ti.com> wrote:
> OK, lets take an example. I have say 2 device instances, say
>         hwlock1: hwlock at 0 {
>                 hwlock-num-locks = <32>
>                 hwlock-base-id = <0>;
>                 #hwlock-cells = <1>;
>         };
>         hwlock2: hwlock at 0 {
>                 hwlock-num-locks = <32>
>                 hwlock-base-id = <32>;
>                 #hwlock-cells = <1>;
>         };
>
>         some-client {
>                 hwlocks = <&hwlock1 32>, <&hwlock2 0>;
>         };
>
> The first args value is incorrect, and I expect the API to return an
> error. I don't think the API can make assumptions that all passed in
> values will be correct. What do you suggest that the API do here?

I think this is just one example of many potential mistakes the DT
developer can have, and that there's nothing really special about it.

What if the '5' digit below is a typo, and the actual hardware
assignment was supposed to be '4' ?

         some-client {
                 hwlocks = <&hwlock1 5>, <&hwlock2 5>;
         };

I don't see how much different this mistake is from the one you
mentioned above. There's a limit to how much we can really catch DT
mistakes in the code, just like we couldn't really catch past mistakes
in the platform data structures.

If we can easily add some validations then great, but if we have to go
to great lengths just to gain very limited validations, then I'd vote
against doing so.

> One solution to handle #1 is to also make the hwlock-num-locks property
> also mandatory (even though it could have been read from a register

Yeah, this is awkward. We shouldn't impose this on implementations
like OMAP which don't need it.

Again I think for the very limited validation this buys us - it's not worth it.

> And, how do you propose we solve the problem of deferred probing?

It seems to me that hwspin_lock_request_specific failures should be
used by clients to defer their probing. Why wouldn't such a simple
solution work?

Thanks,
Ohad.
