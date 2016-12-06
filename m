From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 6 Dec 2016 16:19:56 +0100
Subject: [PATCH v4 6/7] IIO: add STM32 timer trigger driver
In-Reply-To: <20161206131635.GJ25385@dell.home>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
 <1481027929-13704-7-git-send-email-benjamin.gaignard@st.com>
 <20161206131635.GJ25385@dell.home>
Message-ID: <CA+M3ks6fxCucmaY0OgpMb_opA=YLrowijJ0YQ+imeprhWg6N_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]
>> +
>> +static const char * const triggers0[] = {
>> +     TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL,
>> +};
>> +
>> +static const char * const triggers1[] = {
>> +     TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL,
>> +};
>> +
>> +static const char * const triggers2[] = {
>> +     TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL,
>> +};
>> +
>> +static const char * const triggers3[] = {
>> +     TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL,
>> +};
>> +
>> +static const char * const triggers4[] = {
>> +     TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL,
>> +};
>> +
>> +static const char * const triggers5[] = {
>> +     TIM6_TRGO, NULL,
>> +};
>> +
>> +static const char * const triggers6[] = {
>> +     TIM7_TRGO, NULL,
>> +};
>> +
>> +static const char * const triggers7[] = {
>> +     TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL,
>> +};
>> +
>> +static const char * const triggers8[] = {
>> +     TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL,
>> +};
>> +
>> +static const char * const triggers9[] = {
>> +     TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL,
>> +};
>> +
>> +static const void *triggers_table[] = {
>> +     triggers0,
>> +     triggers1,
>> +     triggers2,
>> +     triggers3,
>> +     triggers4,
>> +     triggers5,
>> +     triggers6,
>> +     triggers7,
>> +     triggers8,
>> +     triggers9,
>> +};
>
> What about:
>
> static const char * const triggers[][] = {
>         { TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL },
>         { TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL },
>         { TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL },
>         { TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL },
>         { TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL },
>         { TIM6_TRGO, NULL },
>         { TIM7_TRGO, NULL },
>         { TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL },
>         { TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL },
>         { TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL }
> };

I can't because the second dimension of the array isn't fix.
I could have between 2 and 6 elements per row... to create a dual dimension
array I would have to add NULL entries like that:

#define MAX_TRIGGERS 6

static const void *triggers_table[][MAX_TRIGGERS] = {
{ TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL,},
{ TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL,},
{ TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL,},
{ TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL,},
{ TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL,},
{ TIM6_TRGO, NULL,     NULL,     NULL,     NULL,     NULL,},
{ TIM7_TRGO, NULL,     NULL,     NULL,     NULL,     NULL,},
{ TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL,},
{ TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL,     NULL,     NULL,},
{ TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL,  NULL,     NULL,},
};

>> +static const char * const valids0[] = {
>> +     TIM5_TRGO, TIM2_TRGO, TIM4_TRGO, TIM3_TRGO, NULL,
>> +};
>> +
>> +static const char * const valids1[] = {
>> +     TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO, NULL,
>> +};
>> +
>> +static const char * const valids2[] = {
>> +     TIM1_TRGO, TIM8_TRGO, TIM5_TRGO, TIM4_TRGO, NULL,
>> +};
>> +
>> +static const char * const valids3[] = {
>> +     TIM1_TRGO, TIM2_TRGO, TIM3_TRGO, TIM8_TRGO, NULL,
>> +};
>> +
>> +static const char *const valids4[] = {
>> +     TIM2_TRGO, TIM3_TRGO, TIM4_TRGO, TIM8_TRGO, NULL,
>> +};
>> +
>> +static const char * const valids7[] = {
>> +     TIM1_TRGO, TIM2_TRGO, TIM4_TRGO, TIM5_TRGO, NULL,
>> +};
>> +
>> +static const char * const valids8[] = {
>> +     TIM2_TRGO, TIM3_TRGO, NULL,
>> +};
>> +
>> +static const char * const valids9[] = {
>> +     TIM4_TRGO, TIM5_TRGO, NULL,
>> +};
>> +
>> +static const void *valids_table[] = {
>> +     valids0,
>> +     valids1,
>> +     valids2,
>> +     valids3,
>> +     valids4,
>> +     NULL,
>> +     NULL,
>> +     valids7,
>> +     valids8,
>> +     valids9,
>> +};
>
> Same here.
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
