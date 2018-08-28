From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 28 Aug 2018 16:09:07 +0100
Subject: [PATCH v2 01/29] nvmem: add support for cell lookups
In-Reply-To: <20180828165309.0594ae13@bbrezillon>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-2-brgl@bgdev.pl> <20180824170848.29594318@bbrezillon>
 <20180824152740.GD27483@lunn.ch> <20180825082722.567e8c9a@bbrezillon>
 <CAMRc=Men-MPk5DGshWcVEc0v=gH2WSpx1j-CawOeydwp59tejw@mail.gmail.com>
 <20180827110055.122988d0@bbrezillon>
 <CAMRc=MfpZJUEAhM4OoLbmJcnX3rTJk8fvdiL6=9BjNkVcsf=SA@mail.gmail.com>
 <8cb75723-dc87-f127-2aab-54dd0b08eee8@linaro.org>
 <CAMRc=Mex5WAm8uiV4T=0+bLduBBdj18iekuYT55W9gA_rzQ_sg@mail.gmail.com>
 <916e3e89-82b3-0d52-2b77-4374261a9d0f@linaro.org>
 <CAMRc=MeALxpyBQhWxGPt9BubO_ZwKGih1d8zhRzFYZ0+3kHFAA@mail.gmail.com>
 <20180828165309.0594ae13@bbrezillon>
Message-ID: <af94be21-328b-d6a2-2024-67b98860c3d5@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/08/18 15:53, Boris Brezillon wrote:
> On Tue, 28 Aug 2018 16:41:04 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 

...
> 
>>>
>>>   static struct nvmem_cell *nvmem_find_cell(const char *cell_id)
> 
> Can we get rid of this function and just have the the version that
> takes an nvmem_name and a cell_id.

That should be feasible!


>>>>>
>>>>> I hope you got the reason why of_nvmem_cell_get() always allocates new
>>>>> instance for every get!!
>>>>
>>>>
>>>>
>>>> I admit I didn't test it, but just from reading the code it seems like
>>>> in nvmem_cell_get() for DT-users we'll always get to
>>>> of_nvmem_cell_get() and in there we always end up calling line 873:
>>>> cell = kzalloc(sizeof(*cell), GFP_KERNEL);
>>>>   
>>> That is correct, this cell is created when we do a get and release when we
>>> do a put().
>>>   
>>
>> Shouldn't we add the cell to the list, and check first if it's there
>> and only create it if not?
> 
> Or even better: create the cells at registration time so that the
> search code is the same for both DT and non-DT cases. Only the
> registration would differ (with one path parsing the DT, and the other
> one searching for nvmem cells defined with a nvmem-provider-lookup
> table).
Makes sense! and that would go very well with the plan of "nvmem-cell" 
compatible for cells!.
> 
