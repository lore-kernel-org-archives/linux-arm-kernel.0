From: dianders@chromium.org (Doug Anderson)
Date: Mon, 26 Oct 2015 18:43:00 -0700
Subject: [PATCH 0/4] Patches to fix remote wakeup on rk3288 dwc2 "host"
 port
In-Reply-To: <CAD=FV=UfdEN4MzAwZLWDTQ4qMakhchpr063U1e3uk6R96wScJw@mail.gmail.com>
References: <1445624891-31680-1-git-send-email-dianders@chromium.org>
 <562B9F5F.1080800@kernel.org>
 <CAD=FV=VgYU8sZfSkbNbbOFpb-nt=Yy9NjybxADBnAiQXfasDpw@mail.gmail.com>
 <CAL_JsqLtYrzvreV68V5S0wFJNAR6JusnqZrLjsJwT6yXgrQKHg@mail.gmail.com>
 <CAD=FV=UfdEN4MzAwZLWDTQ4qMakhchpr063U1e3uk6R96wScJw@mail.gmail.com>
Message-ID: <CAD=FV=VKhBheVVBFT9DRDgd32o54RV8Er8sKqCHUvZm3ChnBRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 26, 2015 at 4:49 PM, Doug Anderson <dianders@chromium.org> wrote:
> One note: the "full" PHY reset is actually not in the register map of
> the PHY.  It is amazingly enough in the CRU (clock reset unit).  So if
> we actually exposed the "full" reset through the PHY framework, the
> PHY would then turn around and pass it off to the reset framework,
> which is how the full PHY reset is exposed from the CRU.

Interestingly enough, it looks like there's a reasonable chance that
we won't be able to use the PHY port reset.  We might have to go back
to the full PHY reset (though it causes de-enumeration and
re-enumeration) for safety, since there might be some side effects of
the "phy port reset".

Probably shouldn't land this series until we can figure that out.
...but in that case we still have the question of how we should export
it.  It would certainly be easy to keep using the reset framework...
