From: robherring2@gmail.com (Rob Herring)
Date: Wed, 22 May 2013 16:27:55 -0500
Subject: [RFC/PATCH 0/2] Remove most of_device_match() calls
In-Reply-To: <1369255217-29764-1-git-send-email-sboyd@codeaurora.org>
References: <1369255217-29764-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAL_JsqLm5VAj-5ctWVsCmx5Jewv-hyi2j65XWo4h1WFBMPPumg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 3:40 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Sending this as an RFC with one driver converted to see what people
> think. The goal is to avoid having to run the match twice and be
> similar to how platform_device_id works right now. If people agree
> I can go through and send out patches for all the drivers doing
> the duplicate search (~100 files).
>

See this commit:

commit b1608d69cb804e414d0887140ba08a9398e4e638
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Wed May 18 11:19:24 2011 -0600

    drivercore: revert addition of of_match to struct device

    Commit b826291c, "drivercore/dt: add a match table pointer to struct
    device" added an of_match pointer to struct device to cache the
    of_match_table entry discovered at driver match time.  This was unsafe
    because matching is not an atomic operation with probing a driver.  If
    two or more drivers are attempted to be matched to a driver at the
    same time, then the cached matching entry pointer could get
    overwritten.

    This patch reverts the of_match cache pointer and reworks all users to
    call of_match_device() directly instead.

    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
