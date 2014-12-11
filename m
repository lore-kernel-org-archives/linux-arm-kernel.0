From: dianders@chromium.org (Doug Anderson)
Date: Thu, 11 Dec 2014 13:58:20 -0800
Subject: [PATCH] i2c: rk3x: Account for repeated start time requirement
In-Reply-To: <1418325511-16648-1-git-send-email-dianders@chromium.org>
References: <1418325511-16648-1-git-send-email-dianders@chromium.org>
Message-ID: <CAD=FV=VT_vzn_7EPfokA50B42ObDuXdtWEu72Dq6DHXt0QXFzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 11, 2014 at 11:18 AM, Doug Anderson <dianders@chromium.org> wrote:
> -       min_low_ns = spec_min_low_ns + fall_ns;
> -       min_high_ns = spec_min_high_ns + rise_ns;
> +       /*
> +        * For repeated start we need at least (spec_setup_start * 2) to meet
> +        * (tSU;SDA) requirements. The controller drops data low at half the
> +        * high time). Also need to meet normal specification requirements.
> +        */
> +       if (for_start)
> +               min_high_ns = max(spec_setup_start * 2,
> +                                 spec_setup_start + sda_fall_ns +
> +                                 spec_min_high_ns);
> +       else
> +               min_high_ns = spec_min_high_ns;
> +       min_high_ns += scl_rise_ns;
> +
> +       min_low_ns = spec_min_low_ns + scl_fall_ns;

Sorry I didn't think about this before, but I think the above has a
slight bug.  I need to account for the scl_rise_ns rise time twice in
the repeated start case, I believe.  I'll send out a new version
shortly.
