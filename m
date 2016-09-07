From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 7 Sep 2016 13:29:50 +0200
Subject: [PATCH] simplefb: Disable and release clocks and regulators in
 destroy callback
In-Reply-To: <CAMuHMdU3dgPzvHkd8qti1pwzf1aeUhyv7gdpufYkqxHPS4=VTw@mail.gmail.com>
References: <20160907090919.27187-1-wens@csie.org>
 <CAMuHMdU3dgPzvHkd8qti1pwzf1aeUhyv7gdpufYkqxHPS4=VTw@mail.gmail.com>
Message-ID: <dc027024-c2ad-85fa-8671-53781c95c584@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07-09-16 13:12, Geert Uytterhoeven wrote:
> On Wed, Sep 7, 2016 at 11:09 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> simplefb gets unregister when a proper framebuffer driver comes in and
>> kicks it out. However the claimed clocks and regulators stay enabled
>> as they are only released in the platform device remove function, which
>> in theory would never get called.
>>
>> Move the clock/regulator cleanup into the framebuffer destroy callback,
>> which gets called as part of the framebuffer unregister process.
>
> Is this called before or after the new proper framebuffer driver kicks in?
> If before, it may cause glitches.

It is called by the new proper framebuffer driver's probe method,
so it can make sure that it has already claimed / enabled the
clocks/regulators before it calls remove_conlicting_framebuffers,
avoiding the glitch.

Regards,

Hans
