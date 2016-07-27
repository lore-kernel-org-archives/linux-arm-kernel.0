From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 27 Jul 2016 12:38:00 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <a90e1e01-b0c8-f57b-ada5-835f9d5736bf@linaro.org>
References: <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
 <57910528.7070902@arm.com> <57911590.50305@linaro.org>
 <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
 <57924104.1080202@linaro.org>
 <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
 <ce78f577-d14a-7b12-c96f-a6ebd8866283@linaro.org>
 <20160726175447.GA28376@leverpostej>
 <a90e1e01-b0c8-f57b-ada5-835f9d5736bf@linaro.org>
Message-ID: <20160727113759.GB7147@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2016 at 12:19:59PM +0100, Daniel Thompson wrote:

[...]

> It is interesting to note that you force large_func() to stack its arguments
> (by providing 8 dummy int arguments first) then the implicit
> pass-by-reference behavior is still preserved even for a stacked argument;
> large_func() ends up as:
> 
> ~~~
> large_func:
> 	ldr	x0, [sp]
> 	ldr	x0, [x0]
> 	ret
> ~~~
> 
> Only thing is... I *still* haven't found anything in the AArch64 PCS which
> describes this behavior.
> 
> I'm coming to believe that this is a mistake and this information (and the
> threshold at which implicit pass-by-reference kicks in) should be documented
> in section 7.

Is that answered by this?

    B.3. If the argument type is a Composite Type that is larger than
    16 bytes, then the argument is copied to memory allocated by the
    caller and the argument is replaced by a pointer to the copy.

Experimenting with gcc's behaviour seems to back this up.

Cheers
---Dave
