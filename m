From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sun, 27 May 2018 12:18:05 +0200
Subject: [PATCH] PM / runtime: Drop usage count for suppliers at device
 link removal
In-Reply-To: <1527150816-8459-1-git-send-email-ulf.hansson@linaro.org>
References: <1527150816-8459-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAJZ5v0gGLvKS6yDuBokJzm2gAhM=VMSaz5frvWq=eRPkAD-z6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 10:33 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> In the case consumer device is runtime resumed, while the link to the
> supplier is removed, the earlier call to pm_runtime_get_sync() made from
> rpm_get_suppliers() does not get properly balanced with a corresponding
> call to pm_runtime_put(). This leads to that suppliers remains to be
> runtime resumed forever, while they don't need to.
>
> Let's fix the behaviour by calling rpm_put_suppliers() when dropping a
> device link. Not that, since rpm_put_suppliers() checks the
> link->rpm_active flag, we can correctly avoid to call pm_runtime_put() in
> cases when we shouldn't.
>
> Reported-by: Todor Tomov <todor.tomov@linaro.org>
> Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Rafael, I am not sure if this is safe from locking point of view. The device
> link write lock has been taken when pm_runtime_drop_link() is called, hence I
> assume calling rpm_put_suppliers() should be fine!? If not, can you please
> advise how to change?

Holding the lock should be sufficient for the list to be stable, so
AFAICS it is OK.

Thanks,
Rafael
