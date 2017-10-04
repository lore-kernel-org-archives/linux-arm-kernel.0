From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue, 3 Oct 2017 18:55:51 -0700
Subject: [PATCH 2/7] gpio: brcmstb: release the bgpio lock during irq
 handlers
In-Reply-To: <20170930034057.15166-3-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
 <20170930034057.15166-3-opendmb@gmail.com>
Message-ID: <CADtm3G58SBF0FskUPJCs_8km8oXrKYs-+hrJoV4osyw9mvQbiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Fri, Sep 29, 2017 at 8:40 PM, Doug Berger <opendmb@gmail.com> wrote:
> The basic memory-mapped GPIO controller lock must be released
> before calling the registered GPIO interrupt handlers to allow
> the interrupt handlers to access the hardware.  Otherwise, the
> hardware accesses will deadlock when they attempt to grab the
> lock.

I was having some trouble understanding exactly what the problem was
here, but I think I see it now.  Since this locks the entire bank,
where some GPIOs might be set as inputs and some as inputs (and
interrupt sources), then an interrupt on a GPIO that is supposed to
set another GPIO in the bank would result in deadlock.  Is that
correct?  If so, please update the commit message to make that clear,
and nice fix.  If not that, it would be nice to know what scenario can
cause a problem.

Thanks,
Gregory
