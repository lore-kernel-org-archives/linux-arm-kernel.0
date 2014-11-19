From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 19 Nov 2014 13:16:24 +0530
Subject: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
In-Reply-To: <1714555.tu97zMrOn0@vostro.rjw.lan>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org>
 <2808463.UGmrrQ79Aq@vostro.rjw.lan>
 <CAKohpomgci3S+PZUhm3svuxX+V+pNvHxQqX4m=QmPzd00sxPwg@mail.gmail.com>
 <1714555.tu97zMrOn0@vostro.rjw.lan>
Message-ID: <CAKohpoknu=V_wscVPWLdZO8xEGY6CVMNXuP4F76GNABnm9K4dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2014 02:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, November 18, 2014 08:38:14 AM Viresh Kumar wrote:

>> We are allowing addition of duplicate OPPs as a standard thing right now
>> as cpufreq drivers don't get rid of the OPPs they create with DT. So, that
>> shouldn't complain, isn't it ?
>
> Is cpufreq the only user of OPP?  I thought there were other users, so what
> about them?

Probably of CPU OPPs, but I am not sure. Obviously dev OPPs can be used
by others.

> I'm not sure about that.  If they aren't useful for anything after
> that, what's the benefit of keeping them around?

I don't think they are of any use once the driver is gone, unless the driver is
inserted again.

So, this is what we can do to distinguish DT OPPs with other dynamic ones:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 490e9db..7e25f01 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -49,6 +49,7 @@
  *             are protected by the dev_opp_list_lock for integrity.
  *             IMPORTANT: the opp nodes should be maintained in increasing
  *             order.
+ * @from_dt:   created from static DT entries.
  * @available: true/false - marks if this OPP as available or not
  * @rate:      Frequency in hertz
  * @u_volt:    Nominal voltage in microvolts corresponding to this OPP
@@ -61,6 +62,7 @@ struct dev_pm_opp {
        struct list_head node;

        bool available;
+       bool from_dt;
        unsigned long rate;
        unsigned long u_volt;



Does this look fine? I can then write of_free_opp_table(), opposite of
of_init_opp_table().
