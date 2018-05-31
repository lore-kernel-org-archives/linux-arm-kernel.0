From: collinsd@codeaurora.org (David Collins)
Date: Wed, 30 May 2018 18:03:17 -0700
Subject: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=VNVE5ttNg+7xmgh-p1sFbCxCY1DJiri0JtHFax+zVsnA@mail.gmail.com>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
 <20180530103720.GH6920@sirena.org.uk>
 <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
 <20180530155044.GR6920@sirena.org.uk>
 <CAD=FV=WVUmvPPd5BxXv9Sa_2CRPrrjQvYFyqroY-3fRr4f0Bzg@mail.gmail.com>
 <20180530162007.GU6920@sirena.org.uk>
 <CAD=FV=WL9enzYCoSx0fT_ny40ciLJU-hhS9joJ6nySXvWPqAxQ@mail.gmail.com>
 <75088820-f20d-32ac-780a-5e7dacdf20ff@codeaurora.org>
 <CAD=FV=VNVE5ttNg+7xmgh-p1sFbCxCY1DJiri0JtHFax+zVsnA@mail.gmail.com>
Message-ID: <f4eecb39-9780-c932-4c69-4c8e0d8757a5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On 05/30/2018 05:34 PM, Doug Anderson wrote:
> On Wed, May 30, 2018 at 4:39 PM, David Collins <collinsd@codeaurora.org> wrote:
>> Consider the case of a regulator with physical 10 mA LPM max current. Say
>> that modem and application processors each have a load on the regulator
>> that draws 9 mA. If they each respect the 10 mA limit, then they'd each
>> vote for LPM. The VRM block in RPMh hardware will aggregate these requests
>> together using a max function which will result in the regulator being set
>> to LPM, even though the total load is 18 mA (which would require high
>> power mode (HPM)). To get around this corner case, a LPM max current of 1
>> uA can be used for all LDO supplies that have non-application processor
>> consumers. Thus, any non-zero regulator_set_load() current request will
>> result in setting the regulator to HPM (which is always safe).
> 
> Is there any plan to change the way this works for future versions of RPMh?

As far as I know, no.  Adding VRM logic to sum RPMh client load current
requests, compare the sums to thresholds, select corresponding modes, and
override with explicit modes was determined to be too complex for RPMh.
Instead, much simpler max aggregation was implemented along with design
guidelines for PMICs to ensure that mode values are ordered from strictly
lower to higher power.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
