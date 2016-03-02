From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 2 Mar 2016 15:32:16 -0700
Subject: [PATCH net-next V2 04/16] net: fec: reduce interrupts
In-Reply-To: <CAHrpEqQkuH1JQfKFa=S+ZqbnHpR_SdihM3_dJ++nokV1tczM_Q@mail.gmail.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-5-git-send-email-troy.kisky@boundarydevices.com>
 <VI1PR0401MB18558A7D0A57FA8EDBAD5EABFFBC0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
 <56D710EB.5000201@boundarydevices.com>
 <CAHrpEqQkuH1JQfKFa=S+ZqbnHpR_SdihM3_dJ++nokV1tczM_Q@mail.gmail.com>
Message-ID: <56D769F0.9070901@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/2/2016 9:47 AM, Zhi Li wrote:
> On Wed, Mar 2, 2016 at 10:12 AM, Troy Kisky
> <troy.kisky@boundarydevices.com> wrote:
>> On 3/2/2016 8:13 AM, Fugang Duan wrote:
>>> From: Troy Kisky <troy.kisky@boundarydevices.com> Sent: Thursday, February 25, 2016 8:37 AM
>>>>
>>>> -    if (fep->ptp_clock)
>>>> +    if ((int_events & FEC_ENET_TS_TIMER) && fep->ptp_clock)
>>>>              fec_ptp_check_pps_event(fep);
>>>> -
>>> This is error in here.  FEC compare timer event is not TS timer.
>>>
>>>
>>
>>
>> So when should fec_ptp_check_pps_event be called ? On every interrupt ?
> 
> Compare event is not showed in EIR register.  Need check TCSR, please
> see below code.
> 
> uint fec_ptp_check_pps_event(struct fec_enet_private *fep)
> {
> xx
>  val = readl(fep->hwp + FEC_TCSR(channel));
>         if (val & FEC_T_TF_MASK) {
> }


So, should FEC_ENET_TS_TIMER be removed from FEC_DEFAULT_IMASK, since
the interrupt routine never checks it ?
