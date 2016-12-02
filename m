From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Dec 2016 13:32:53 +0100
Subject: [resend v2: PATCH 1/2] dt-bindings: Document the hi3660 reset
 bindings
In-Reply-To: <e15e76e2-b32d-a4d0-eb8b-850626a3946a@linaro.org>
References: <1480553321-17400-1-git-send-email-zhangfei.gao@linaro.org>
 <3900806.3NUubBDb0Q@wuerfel>
 <e15e76e2-b32d-a4d0-eb8b-850626a3946a@linaro.org>
Message-ID: <5982682.vMJxVociDa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 2, 2016 8:21:33 AM CET zhangfei wrote:
> Hi, Arnd
> 
> On 2016?12?01? 20:05, Arnd Bergmann wrote:
> > On Thursday, December 1, 2016 8:48:40 AM CET Zhangfei Gao wrote:
> >> +               hisi,reset-bits = <0x20 0x8             /* 0: i2c0 */
> >> +                                  0x20 0x10            /* 1: i2c1 */
> >> +                                  0x20 0x20            /* 2: i2c2 */
> >> +                                  0x20 0x8000000>;     /* 3: i2c6 */
> >> +       };
> >> +
> >> +Specifying reset lines connected to IP modules
> >> +==============================================
> >> +example:
> >> +
> >> +        i2c0: i2c at ..... {
> >> +                ...
> >> +               resets = <&iomcu_rst 0>;
> >> +                ...
> >> +        };
> > I don't really like this approach, since now the information is
> > in two places. Why not put the data into the reset specifier
> > directly when it is used?
> Any example, still not understand.
> They are consumer and provider.

I mean in the i2c node, have

	i2c0: i2c at ..... {
		...
		resets = <&iomcu_rst 0x20 0x8>;
		...
	}

> > Also the format seems a little too close to the actual register
> > layout and could be a little more abstract, using bit numbers instead
> > of a bitmask and register numbers instead of offsets.
> We use bit numbers first.
> But in the developing process, we found several bits may be required for 
> one driver.
> And they may not be continuous as the bits may already be occupied.
> Directly using offset, we can set several bits together for simple, to 
> give more flexibility.
> So after discussion, we directly use offset.

Can you give an example for why this is needed? Is this different
from a device that has multiple reset lines?

	Arnd
