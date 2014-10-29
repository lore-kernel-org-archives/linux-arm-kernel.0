From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 29 Oct 2014 13:00:14 -0700
Subject: [PATCH v6 4/7] ARM: rockchip: add suspend and resume for RK3288
In-Reply-To: <CAD=FV=Vabh6xJOYxkuGiG_AFr2qm26iqL87LJ_CBzK1w+dC9XA@mail.gmail.com>
 (Doug Anderson's message of "Wed, 29 Oct 2014 12:26:32 -0700")
References: <1414583525-17395-1-git-send-email-zyw@rock-chips.com>
 <1414583525-17395-5-git-send-email-zyw@rock-chips.com>
 <7h38a68zu9.fsf@deeprootsystems.com>
 <CAD=FV=Vabh6xJOYxkuGiG_AFr2qm26iqL87LJ_CBzK1w+dC9XA@mail.gmail.com>
Message-ID: <7hy4ry7ik1.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson <dianders@chromium.org> writes:

> Kevin,
>
> On Wed, Oct 29, 2014 at 12:01 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>> +     /* set bit 8 so that system will resume to FAST_BOOT_ADDR */
>>> +     regmap_write(sgrf_regmap, RK3288_SGRF_SOC_CON0,
>>> +                  BIT(SGRF_FAST_BOOT_EN) | BIT(SGRF_FAST_BOOT_EN + 16));
>>
>> Comment says "bit 8", but code says bit 8 and bit 24, and if bit 24 is
>> needed, it should probably get its own #define in the header.
>
> This is Rockchip's "write enable" feature hitting us again.  The upper
> 16-bits are "write enables" for the lower 16-bits.  So to set bit 8
> you set bit 8 to whatever value you want and then 'write enable' by
> setting (1 << 8 << 16).  It allows you to avoid read-modify-write.
> See this in Rockchip's clk.h:
>
> #define HIWORD_UPDATE(val, mask, shift) \
>                 ((val) << (shift) | (mask) << ((shift) + 16))

OK, sounds like a macro is needed in the core code as well (with a
comment for those of us who will forget why it's needed)

Kevin
