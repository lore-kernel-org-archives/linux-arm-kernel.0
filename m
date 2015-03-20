From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 20 Mar 2015 11:55:50 +0100
Subject: [PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()
In-Reply-To: <20150319113646.GQ2869@sirena.org.uk>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
 <1426112117-18220-2-git-send-email-dianders@chromium.org>
 <CAPDyKFq_WMJfqNGuxwN7xPmhv2X6-+G1zXpdD6zYDkDe7-Jo2A@mail.gmail.com>
 <CAD=FV=U-YnT5jF5MFC==hANXGPqVpV3iLMPu85TrQ4dNDsWeCA@mail.gmail.com>
 <CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
 <CAD=FV=X=1=AnXCGgWWkJDcHLO-MfVqsSB2aJxi3WOgWJhD_ggA@mail.gmail.com>
 <CAPDyKFrkznbW7k_=BDo99jJhWzDbUgbeU+MXWB_E_UWXh=56Eg@mail.gmail.com>
 <20150319113646.GQ2869@sirena.org.uk>
Message-ID: <CAPDyKFroe9N3j9oMWKknH5huv7j8fkrBr5UKjjp190hkqNsNRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 March 2015 at 12:36, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Mar 19, 2015 at 12:14:11PM +0100, Ulf Hansson wrote:
>
>> Agree. Moreover we need that API to also pick the closest value to
>> target, when trying the range "target->minimum". I also believe it
>
> The implementation *should* do that anyway, it's just not trivial to
> implement in an efficient fashion with the current information we have
> from drivers.

The APIs regulator_count_voltages() and regulator_list_voltage(), are
currently used from the mmc core to find out which voltages that is
supported (with 0.1V granularity). Then that information can be used
when trying to set a new voltage.

But I guess such a wrapper API is out of the question?

Anyway, I get the feeling that we will need to do the same for this case.

>
>> would be good to allow both upper and lower limits to be zero.
>
> The lower limit can be zero already though it isn't clear to me that
> this is useful.  Setting an upper limit of zero seems nonsensical, an
> upper limit that is lower than the lower limit isn't terribly obvious
> and removing the upper limit isn't safe - it means that we'll happily
> oversupply things which is a road to physical damage.

I am not sure I follow here. In the regulator_set_voltage_tol() you
can only specifiy one limit (tolerance?). What Dough proposed was to
add a new API which can have both a low tolerance value and a high
tolerance value.

Kind regards
Uffe
